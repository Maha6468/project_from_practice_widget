import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../colors/app_colors.dart';
import '../../common/global_widget.dart';

import '../../common/perferenceVisibility.dart';
import '../../common/perfrance.dart';
import '../../controllers/home_page_controller.dart';
import '../../controllers/main_page_controller.dart';
import '../../enums.dart';
import '../../routes/app_pages.dart';
import '../pages/notification_page.dart';
import '../pages/profile_page.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  MainAppBar({super.key});
  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56); // Move the preferredSize here
}

class _MainAppBarState extends State<MainAppBar> with WidgetsBindingObserver {
  final MainPageController controller = Get.put(MainPageController());
  bool hasUnreadNotification = false;
  final HomePageController homeController = Get.put(HomePageController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Listen for new notifications
    // Set hasUnreadNotification to true when a new notification arrives
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (mounted) {
        setState(() {
          hasUnreadNotification = true;
        });
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Check for unread notifications when the app is resumed
      checkUnreadNotifications();
    }
  }

  void checkUnreadNotifications() {
    // Implement your logic to check if there are any unread notifications
    // If there are no unread notifications, set hasUnreadNotification to false
    // Otherwise, keep it true
    setState(() {
      // For demonstration purposes, assuming there are no unread notifications
      hasUnreadNotification = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(56),
      child: Container(
        height: 90,
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 35,
        ),
        width: Get.width,
        color: AppColors.appSecondaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    if(homeController.isMinings.isFalse && homeController.isMiningEnabled.isTrue){
                      errorSnack('Please start mining first');
                      return;
                    }
                    Scaffold.of(context).openDrawer();
                  },
                  child: Image(
                    height: 30,
                    width: 30,
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/ham_burg_menu_icon.png'),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                InkWell(
                  onTap: (){
                    if(homeController.isMinings.isFalse && homeController.isMiningEnabled.isTrue){
                      errorSnack('Please start mining first');
                      return;
                    }
                    Get.toNamed(Routes.MAIN);
                    controller.selectedBottomBarItem.value = PageName.home;
                  },
                  child: Image(
                      height: 40,
                      width: 40,
                      image: AssetImage('assets/images/orbaic_white_logo.png')),
                ),
                SizedBox(
                  width: 2,
                ),
                Obx(
                      () => Text(
                    controller.selectedBottomBarItem.value == PageName.home
                        ? 'Orbaic'
                        : controller.selectedBottomBarItem.value == PageName.wallet
                        ? 'Wallet'
                        : controller.selectedBottomBarItem.value == PageName.support
                        ? 'Support'
                        : controller.selectedBottomBarItem.value == PageName.team
                        ? 'Team'
                        : 'Orbaic',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.59,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    if(homeController.isMinings.isFalse && homeController.isMiningEnabled.isTrue){
                      errorSnack('Please start mining first');
                      return;
                    }
                    Get.to(() => NotificationPage());
                  },
                  child: PreferenceVisibility(
                    preferenceKey: Pref.miningEnabledStatus,
                    child: Stack(
                      children: [
                        Icon(
                          Icons.notifications_none_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        if (hasUnreadNotification)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    if(homeController.isMinings.isFalse && homeController.isMiningEnabled.isTrue){
                      errorSnack('Please start mining first');
                      return;
                    }
                    Get.to(() => ProfilePage());
                  },
                  child: PreferenceVisibility(
                    preferenceKey: Pref.miningEnabledStatus,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image(
                        height: 40,
                        width: 40,
                        image: AssetImage('assets/images/avatar.png'),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}