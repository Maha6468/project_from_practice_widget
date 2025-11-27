import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../colors/app_colors.dart';
import '../../common/global_widget.dart';
import '../../controllers/support_page_controller.dart';
import '../widgets/dialogs.dart';

class SupportPage extends StatelessWidget {
  SupportPage({super.key});

  final SupportPageController controller = Get.put(SupportPageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: AppColors.appSecondaryBackgroundColor,
      padding: EdgeInsets.only(left: 12, right: 12),
      child: ListView(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //    crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12,),
          Text(
            'subject'.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.59,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: AppColors.appBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: TextField(
              controller: controller.subjectController,
              style: TextStyle(color: Colors.white),
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
          SizedBox(
            height: 15,
          ),
          Text(
            'description'.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.59,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: AppColors.appBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Column(
              children: [
                SizedBox(
                    width: Get.height - 30,
                    child: TextFormField(
                      maxLines: 3,
                      controller: controller.descriptionController,
                      onChanged: (value) {
                        // Update character count
                        controller.updateCharacterCount(value.length);
                      },
                      style: TextStyle(color: Colors.white),
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
                    )),
                SizedBox(
                  height: 5,
                ),
                Obx(
                      () => Row(
                    children: [
                      Spacer(),
                      Text(
                        '${controller.characterCount}/1000',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.59,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          /*  SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                color: Color(0x3361C7C4),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: DottedBorder(
              borderType: BorderType.RRect,
              padding: EdgeInsets.all(12),
              radius: Radius.circular(12),
              color: Color(0xff61C7C4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload, color: Color(0xff61C7C4)),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'upload_ss'.tr,
                    style: TextStyle(
                      color: Color(0xFF61C7C4),
                      fontSize: 13.36,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),*/
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () {
              if (controller.subjectController.value.text == "" &&
                  controller.descriptionController.value.text == "") {
                errorSnack("subject_not_empty".tr);
              }

              else if (controller.subjectController.value.text == "") {
                errorSnack("enter_subject".tr);
              }

              else if (controller.descriptionController.value.text == "") {
                errorSnack("Please Enter Description");
              }


              else {
                controller.sendSupportRequest(
                    subject: controller.subjectController.value.text,
                    description: controller.descriptionController.value.text
                );
              }
            },
            child: Center(
              child: Container(
                width: Get.width / 2,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.appSecondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Center(
                  child: Text(
                    'submit'.tr,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.59,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'or'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.59,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                    onTap: () async {
                      String link = "https://t.me/OrbaicEnglish";
                      final action = await Dialogs.leftAppDialog(context, link);
                    },
                    child: Image(image: AssetImage('assets/images/telegram_icon.png'),height: 40, width: 40,)),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                    onTap: () async {
                      String link = "https://twitter.com/Orbaicproject?s=08";
                      final action = await Dialogs.leftAppDialog(context, link);
                    },
                    child: Image(image: AssetImage('assets/images/twitter_icon.png'),height: 40, width: 40,)),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                    onTap: () async {
                      String link = "https://www.facebook.com/orbaic/";
                      final action = await Dialogs.leftAppDialog(context, link);
                    },
                    child: Image(image: AssetImage('assets/images/fb_icon.png'),height: 40, width: 40,)),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(5.0),
              //   child: Image(image: AssetImage('assets/images/insta_icon.png'),height: 40, width: 40,),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(5.0),
              //   child: Image(image: AssetImage('assets/images/youtube_icon.png'),height: 40, width: 40,),
              // ),
            ],)
        ],
      ),
    );
  }
}