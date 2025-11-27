import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../colors/app_colors.dart';
import '../../common/firebase_notification/save_notification_list.dart';
import '../widgets/home_drawer.dart';
import '../widgets/secondary_app_bar.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}
class _NotificationPageState extends State<NotificationPage> {
  final NotificationManager _notificationManager = NotificationManager();
  late List<NotificationClass> _notifications = [];
  late Set<String> _expandedNotificationIds = {}; // Use Set to store expanded notification ids

  Future<void> _loadNotifications() async {
    final notifications = await _notificationManager.getNotifications();
    setState(() {
      _notifications = notifications.where((notification) => notification.unread).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadNotifications();
    });
  }

  @override
  void dispose() {
    super.dispose();

    _expandedNotificationIds.forEach((id) async {
      await _notificationManager.markNotificationAsRead(id, _notifications);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: 'notifications'.tr),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.appSecondaryBackgroundColor,
        ),
        child:

        _notifications.isEmpty
            ? Center(
          child: Text('no_notification'.tr,  style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.59,
          ),),
        ):


        ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.appBackgroundColor,
                border: Border(
                  left: BorderSide(
                    color: AppColors.appSecondaryColor,
                    width: 2.0,
                  ),
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Theme(
                data: ThemeData().copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  title: Text(
                    _notifications[index].title,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  initiallyExpanded: _expandedNotificationIds.contains(_notifications[index].id),
                  onExpansionChanged: (expanded) async {
                    if (expanded) {
                      setState(() {
                        _expandedNotificationIds.add(_notifications[index].id);
                        print("Notification Add");
                      });
                    } else {
                      setState(() {
                        _notifications.remove(_notifications[index]);
                        print("Notification removed");
                      });
                      await _notificationManager.deleteAllNotification();
                      await _notificationManager.saveNotifications(_notifications);
                    }
                  },
                  children: <Widget>[
                    Text(
                      _notifications[index].message,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      drawer: HomeDrawer(),
    );
  }
}