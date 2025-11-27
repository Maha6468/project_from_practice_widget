import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class NotificationClass {
  String title;
  String message;
  bool unread;
  String id;


  NotificationClass({
    required this.id,

    required this.title,
    required this.message,
    this.unread = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'unread': unread,
    };
  }

  factory NotificationClass.fromJson(Map<String, dynamic> json) {
    return NotificationClass(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      unread: json['unread'] ?? true,
    );
  }
}

class NotificationManager {
  static const String _keyNotifications = 'notifications';

  Future<void> saveNotifications(List<NotificationClass> notifications) async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve existing notifications
    List<NotificationClass> existingNotifications = await getNotifications();

    // Append new notifications to the existing list
    existingNotifications.addAll(notifications);

    // Convert the combined list to JSON
    final jsonList = existingNotifications.map((notification) => notification.toJson()).toList();
    final jsonString = json.encode(jsonList);

    // Save the combined list
    await prefs.setString(_keyNotifications, jsonString);
  }

  Future<List<NotificationClass>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final jsonString = prefs.getString(_keyNotifications);
    if (jsonString != null) {
      final jsonList = json.decode(jsonString) as List<dynamic>;
      print("-------------All the nofitication---------------------");
      print(jsonList);
      return jsonList.map((json) => NotificationClass.fromJson(json)).toList();

    } else {
      return [];
    }
  }

  Future<bool> markNotificationAsRead(String id, List<NotificationClass> notifications) async {
    final notificationIndex = notifications.indexWhere((element) => element.id == id);
    if (notificationIndex != -1) {
      notifications[notificationIndex].unread = false;
      await saveSingleNotification(notifications[notificationIndex]);
      return true;
    }
    return false;
  }

  Future<void> saveSingleNotification(NotificationClass notification) async {
    final prefs = await SharedPreferences.getInstance();
    final existingNotifications = await getNotifications();
    final notificationIndex = existingNotifications.indexWhere((element) => element.id == notification.id);

    if (notificationIndex != -1) {
      existingNotifications[notificationIndex] = notification;
      final jsonList = existingNotifications.map((notification) => notification.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await prefs.setString(_keyNotifications, jsonString);
    }
  }


  Future<void> deleteAllNotification() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyNotifications);
    // await prefs.setString(_keyNotifications, jsonString);
  }
}
