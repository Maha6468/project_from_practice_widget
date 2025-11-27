import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors/app_colors.dart';
import '../../routes/app_pages.dart';
import '../pages/notification_page.dart';
import '../pages/profile_page.dart';

class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget{
  SecondaryAppBar({super.key, required this.title});
  final String title;
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
                    onTap: (){
                      Scaffold.of(context).openDrawer();
                    },
                    child: Image(
                      height: 30,
                      width: 30,
                      fit: BoxFit.contain,
                      image:
                      AssetImage('assets/images/ham_burg_menu_icon.png'),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.MAIN);
                    },
                    child: Image(
                        height: 40,
                        width: 40,
                        image: AssetImage(
                            'assets/images/orbaic_white_logo.png')),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.59,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(() => NotificationPage());
                    },
                    child: Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(() => ProfilePage());
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image(
                        height: 40,
                        width: 40,
                        image: AssetImage('assets/images/avatar.png'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56);
}