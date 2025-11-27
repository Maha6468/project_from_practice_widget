import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../colors/app_colors.dart';
import '../../common/global_widget.dart';
import '../../controllers/home_page_controller.dart';
import '../../controllers/main_page_controller.dart';
import '../../enums.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final MainPageController controller = Get.put(MainPageController());
  final HomePageController homeController = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appBackgroundColor,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              controller.selectedBottomBarItem.value = PageName.home;
            },
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                        () => Container(color: controller.selectedBottomBarItem.value == PageName.home ?
                    AppColors.appBottomBarSelectedColor : Colors.transparent,
                      margin: EdgeInsets.only(bottom: 3),
                      height: 3, width: 30,),
                  ),
                  Obx(
                        () => Icon(Icons.home,
                        color: controller.selectedBottomBarItem.value == PageName.home ?
                        AppColors.appBottomBarSelectedColor : Colors.white
                    ),
                  ),
                  Obx(
                        () => Text(
                      'home'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: controller.selectedBottomBarItem.value == PageName.home ?
                        AppColors.appBottomBarSelectedColor : Colors.white,
                        fontSize: 11,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              if(homeController.isMinings.isFalse){
                errorSnack('Please start mining first');
                return;
              }
              controller.selectedBottomBarItem.value = PageName.wallet;
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                        () => Container(color: controller.selectedBottomBarItem.value == PageName.wallet ?
                    AppColors.appBottomBarSelectedColor : Colors.transparent,
                      margin: EdgeInsets.only(bottom: 3),
                      height: 3, width: 30,),
                  ),
                  Obx(
                        () => Icon(Icons.wallet, color: controller.selectedBottomBarItem.value == PageName.wallet ?
                    AppColors.appBottomBarSelectedColor : Colors.white),
                  ),
                  Obx(
                        () => Text(
                      'wallet'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: controller.selectedBottomBarItem.value == PageName.wallet ?
                        AppColors.appBottomBarSelectedColor : Colors.white,
                        fontSize: 11,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              if(homeController.isMinings.isFalse){
                errorSnack('Please start mining first');
                return;
              }
              controller.selectedBottomBarItem.value = PageName.team;
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() =>Container(color: controller.selectedBottomBarItem.value == PageName.team ?
                  AppColors.appBottomBarSelectedColor : Colors.transparent,
                    margin: EdgeInsets.only(bottom: 3),
                    height: 3, width: 30,)),
                  Obx(() =>Icon(Icons.people,
                      color: controller.selectedBottomBarItem.value == PageName.team ?
                      AppColors.appBottomBarSelectedColor : Colors.white)),
                  Obx(
                          () =>Text(
                        'team'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: controller.selectedBottomBarItem.value == PageName.team ?
                          AppColors.appBottomBarSelectedColor : Colors.white,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              if(homeController.isMinings.isFalse){
                errorSnack('Please start mining first');
                return;
              }
              controller.selectedBottomBarItem.value = PageName.support;
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                          () => Container(color: controller.selectedBottomBarItem.value == PageName.support ?
                      AppColors.appBottomBarSelectedColor : Colors.transparent,
                        margin: EdgeInsets.only(bottom: 3),
                        height: 3, width: 30,)),
                  Obx(
                          () => Icon(Icons.note,
                          color: controller.selectedBottomBarItem.value == PageName.support ?
                          AppColors.appBottomBarSelectedColor : Colors.white)),
                  Obx(
                          () =>Text(
                        'support'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: controller.selectedBottomBarItem.value == PageName.support ?
                          AppColors.appBottomBarSelectedColor : Colors.white,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}