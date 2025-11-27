import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../ads/AdManager.dart';
import '../../colors/app_colors.dart';
import '../../controllers/profile_update_controller.dart';
import '../widgets/secondary_app_bar.dart';

class ProfileUpdatePage extends GetView {
  const ProfileUpdatePage({super.key});

  @override
  ProfileUpdateController get controller => Get.put(ProfileUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appSecondaryColor,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Image(
                image: AssetImage('assets/images/appbar_back_arrow.png'),
                height: 32,
                width: 32,
              )),
        ),
        title: Text(
          'Profile Update',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.59,
          ),
        ),
      ),
      body: Container(
        width: Get.width,
        color: AppColors.appSecondaryBackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            // Obx(() =>
            // controller.changeFor.value == ChangeFor.NAME ?
            //   _buildListItem(title: 'full_name'.tr, icon: Icons.person) :
            //   _buildListItem(title: 'phone_no'.tr, icon: Icons.phone_android, isPhone: true),
            // ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 3),
                Text(
                  'full_name'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.36,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.appBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: TextField(
                controller: controller.fullNameController,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {},
                decoration: InputDecoration(
                    hintText: "type_here".tr,
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.59,
                    )),
              ),
            ),


            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.add_card,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 3),
                Text(
                  'Govt Id/ Passport/ Any Document',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.36,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () async {
                if (await controller.requestPermissions()) {
                  controller.pickFile();
                }
                // else {
                //   showPermissionDeniedDialog(context);
                // }
              },
              child: Obx(() => Container(
                height: 140,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.appBackgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: controller.fileData.value != null ?
                Image.asset("assets/images/result_icon.png",
                  fit: BoxFit.fitHeight,
                ) : const Icon(Icons.add_box_outlined, size: 50, color: Colors.white30,),
              )),
            ),
            const SizedBox(height: 5),
            Obx(() => controller.fileData.value != null ? Text(
              'File name: ${controller.fileData.value!.name}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Poppins',
                letterSpacing: 0.36,
              ),
            ): const SizedBox.shrink()),


            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.message,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 3),
                Text(
                  'Message',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.36,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.appBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: TextField(
                controller: controller.messageController,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {},
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: "type_here".tr,
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.59,
                    )),
              ),
            ),


            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                // bool isAdReady = await AdManager.instance.isAdReady();
                // if (isAdReady) {
                //   await AdManager.instance.showAd();
                // }
                controller.sendRequest();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.appSecondaryColor,
                  borderRadius: BorderRadius.all(
                      Radius.circular(15)),
                ),
                child: Text(
                  'SUBMIT REQUEST',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.59,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.appBackgroundColor,
        title: Text('Permission Required'),
        content: Text('Please enable storage access in settings'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings(); // From permission_handler package
            },
            child: Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}