import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_from_practice_widget/common/firebase_notification/save_notification_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../firebase_options.dart';
import '../perfrance.dart';
import 'notification_model.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseNotification.instance.setupFlutterNotification();
  await FirebaseNotification.instance.showNotification(message);
}

class FirebaseNotification {
  FirebaseNotification._();

  static final FirebaseNotification instance = FirebaseNotification._();

  static const String ANDROID_CHANNEL_ID = "high_importance_channel";
  static const String ANDROID_CHANNEL_NAME = "High Importance Channel";
  static const String ANDROID_CHANNEL_DESC = "This channel is used for important notifications.";

  final _messaging = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();

  bool _isFlutterLocalNotificationInitialized = false;

  Future<void> initialize() async {
    try {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      // Wrap in try-catch to prevent app crash
      await _requestPermission().catchError((error) {
        print("Error requesting permission: $error");
      });

      await _setupMessageHandlers();

      // Move token retrieval inside try-catch
      await _messaging.getToken().then((fcmToken) async {
        await PreferenceHelper.instance.setData(Pref.fcmToken, fcmToken);
        print('FCM Token: $fcmToken');
      }).catchError((error) {
        print("Error getting FCM token: $error");
      });
    } catch (e) {
      print("Firebase Notification initialization error: $e");
    }
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );
    print('Notification Permission status: ${settings.authorizationStatus}');

    // if (settings.authorizationStatus != AuthorizationStatus.authorized) {
    //   await _requestPermission();
    // }
  }


  Future<void> requestPermissionAgain() async {
    final prefs = await SharedPreferences.getInstance();
    final lastRemindTime = prefs.getInt('last_remind_time') ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    // Show dialog only if a week has passed or it's the first time
    if (now - lastRemindTime < 7 * 24 * 60 * 60 * 1000) {
      return; // Don't show if within 7 days
    }

    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print("authorizationStatus: denied");
      _showNotificationSettingsDialog();
    }


  }

  static bool _isDialogVisible = false;
  void _showNotificationSettingsDialog() async {
    if (_isDialogVisible) return; // Prevent showing the dialog if it's already visible

    _isDialogVisible = true; // Set the flag to true to indicate that the dialog is being shown

    bool remindLater = false;

    // Ensure dialog is triggered on the main UI thread
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      // Await the dialog to wait for the user's response
      bool? result = await Get.dialog(
        StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Enable Notifications"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Notifications are crucial for getting status updates. Please enable them in settings."),
                  Row(
                    children: [
                      Checkbox(
                        value: remindLater,
                        onChanged: (value) {
                          setState(() {
                            remindLater = value!;
                          });
                        },
                      ),
                      Text("Remind me next week"),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (remindLater) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setInt('last_remind_time', DateTime.now().millisecondsSinceEpoch);
                    }
                    Get.back(result: false); // Close dialog with result
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Get.back(result: true); // Close dialog with result
                    openAppSettings(); // Open app settings
                  },
                  child: Text("Settings"),
                ),
              ],
            );
          },
        ),
        barrierDismissible: false, // Prevents accidental dismiss
      );

      // Now, `result` will hold the result of dialog interaction (either true or false)
      if (result == true) {
        // If user clicked 'Settings'
        print("User chose to open settings");
      } else {
        // If user clicked 'Cancel'
        print("User chose to cancel");
      }

      _isDialogVisible = false; // Reset the flag after the dialog is closed
    });
  }

  Future<void> setupFlutterNotification() async {
    if (_isFlutterLocalNotificationInitialized) {
      return;
    }

    /// android setup
    const channel = AndroidNotificationChannel(
      ANDROID_CHANNEL_ID,
      ANDROID_CHANNEL_NAME,
      description: ANDROID_CHANNEL_DESC,
      importance: Importance.high,
    );

    await _localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    /// ios settings
    const initializationSettingsDarwin = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _localNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );

    _isFlutterLocalNotificationInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      await _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            ANDROID_CHANNEL_ID,
            ANDROID_CHANNEL_NAME,
            channelDescription: ANDROID_CHANNEL_DESC,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );

      try {
        final NotificationManager notificationManager = NotificationManager();
        List<NotificationClass> notifications = [];
        notifications.add(NotificationClass(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: notification.title ?? "",
          message: notification.body ?? "",
        ));
        await notificationManager.saveNotifications(notifications);
      } catch (e) {
        print("error insert notifications: $e");
      }
    }
  }

  Future<void> _setupMessageHandlers() async {
    // foreground message
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });

    // background message
    FirebaseMessaging.onMessageOpenedApp.listen(_handlerBackgroundMessage);

    // opened app
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handlerBackgroundMessage(initialMessage);
    }
  }

  void _handlerBackgroundMessage(RemoteMessage message) {
    try {
      NotificationData notificationData = NotificationData(
        tital: message.notification?.title,
        type: message.data['type'],
        id: message.data['id'],
        senderId: message.data['sender_business_id'],
      );
      print(notificationData.toJson());
    } catch (e) {
      print(e);
    }
  }
}