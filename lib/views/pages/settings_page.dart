import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:language_picker/language_picker_dialog.dart';
import 'package:language_picker/languages.dart';
import 'package:project_from_practice_widget/views/pages/profile_page.dart';

import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors/app_colors.dart';
import '../../common/string.dart';
import '../../controllers/settings_controller.dart';
import '../widgets/dialogs.dart';
import '../widgets/home_drawer.dart';
import '../widgets/secondary_app_bar.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: 'settings'.tr,),
      body: Obx(() => Container(
        width: Get.width,
        color: AppColors.appSecondaryBackgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image(
                    height: 100,
                    width: 100,
                    image: AssetImage('assets/images/avatar.png'),
                  ),
                ),
              ],
            ),
            Obx(() => Text(
              controller.fullName.value ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.59,
              ),
            )),
            SizedBox(
              height: 5,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  controller.userId.value ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12.50,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                    onTap: () async {
                      _copyToClipboard(controller.userId.value, context);
                    },
                    child: Icon(
                      Icons.copy_rounded,
                      color: Colors.white.withOpacity(0.5),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: (){
                Get.to(() => ProfilePage());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.appBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Row(children: [
                  Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xff41918B),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Image(image: AssetImage('assets/images/edit_profile_icon.png'),height: 18,width: 18,)
                  ),
                  SizedBox(width: 8,),
                  Text(
                    'edit_profile'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.59,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.chevron_right, color: Colors.white,)
                ],),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.appBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(children: [
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xff41918B),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Image(image: AssetImage('assets/images/add_person_icon.png'),height: 18,width: 18,)
                ),
                SizedBox(width: 8,),
                Text(
                  'my_invitation_code'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.59,
                  ),
                ),
                Spacer(),
                Image(image: AssetImage('assets/images/refer_code_icon.png'),height: 32, width: 40,),
                Text(
                  controller.referCode.value??"",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.44,
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
                    onTap: () async {
                      final result = await Share.share('Orbaic is a Layer 1 Web3 project. Kickstart your ACI token mining journey by downloading the app and signing up. Don\'t forget to enter my referral code in the team section to instantly claim your 2 ACI tokens. Build your team and enjoy an additional 5% Boost when your team members are actively mining.\n\nMy Referral Code: ${controller.referCode.value}\n\nDownload Android app: https://play.google.com/store/apps/details?id=com.orbaic.miner');
                      //  _copyToClipboard(controller.referCode.value, context);
                    },
                    child: Icon(Icons.share, color: Color(0x80FFFFFF),)),
              ],),
            ),

            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.appBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(children: [
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xff41918B),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Image(image: AssetImage('assets/images/kyc_icon.png'),height: 18,width: 18,)
                ),
                SizedBox(width: 8,),
                Text(
                  'kyc_verification'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.59,
                  ),
                ),
                Spacer(),
                InkWell(
                    onTap: () async {
                      String link = "https://www.orbaic.com/roadmap.php";
                      await Dialogs.withLinkDialog(context, "We wanted to inform you that the KYC process is scheduled for Phase 4. For more details, please visit https://www.orbaic.com/roadmap.php.", link);
                    },
                    child: Icon(Icons.remove_red_eye, color: AppColors.appSecondaryColor)),
                SizedBox(width: 7,),
              ],),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.appBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(children: [
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xff41918B),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Image(image: AssetImage('assets/images/language_icon.png'),height: 18,width: 18,)
                ),
                SizedBox(width: 8,),
                Text(
                  'language'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.59,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0x1A61C7C4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(' ${controller.languageName.value} ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.45,
                    ),),
                ),
                SizedBox(width: 8,),
                InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.all(16.0),
                          actionsPadding: EdgeInsets.all(16.0),
                          // Adjust padding as needed

                          backgroundColor: AppColors.appBackgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          title: Text(
                            "change_language".tr,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                          content: Obx(
                                () => DropdownButton(
                              value: controller.languageName.value,
                              underline: Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              onChanged: (value){
                                controller.languageName.value = value!;
                              },
                              items: [
                                DropdownMenuItem<String>(
                                  value: "English",
                                  child: Text('English', style: TextStyle(color: Colors.white),),
                                ),
                                DropdownMenuItem<String>(
                                  value: "Bangla",
                                  child: Text('Bangla', style: TextStyle(color: Colors.white)),
                                ),
                                DropdownMenuItem<String>(
                                  value: "Hindi",
                                  child: Text('Hindi', style: TextStyle(color: Colors.white)),
                                ),
                                DropdownMenuItem<String>(
                                  value: "French",
                                  child: Text('French', style: TextStyle(color: Colors.white)),
                                ),
                                DropdownMenuItem<String>(
                                  value: "Chinese",
                                  child: Text('Chinese', style: TextStyle(color: Colors.white)),
                                ),
                                DropdownMenuItem<String>(
                                  value: "Nigerian",
                                  child: Text('Nigerian', style: TextStyle(color: Colors.white)),
                                ),
                                DropdownMenuItem<String>(
                                  value: "Urdu",
                                  child: Text('Urdu', style: TextStyle(color: Colors.white)),
                                ),
                                DropdownMenuItem<String>(
                                  value: "Vietnamese",
                                  child: Text('Vietnamese', style: TextStyle(color: Colors.white)),
                                ),
                                DropdownMenuItem<String>(
                                  value: "Filipino",
                                  child: Text('Filipino', style: TextStyle(color: Colors.white)),
                                ),
                                DropdownMenuItem<String>(
                                  value: "Indonesian",
                                  child: Text('Indonesian', style: TextStyle(color: Colors.white)),
                                ),
                                DropdownMenuItem<String>(
                                  value: "Spanish",
                                  child: Text('Spanish', style: TextStyle(color: Colors.white)),
                                ),
                                DropdownMenuItem<String>(
                                  value: "German",
                                  child: Text('German', style: TextStyle(color: Colors.white)),
                                ),
                                DropdownMenuItem<String>(
                                  value: "Arabic",
                                  child: Text('Arabic', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            InkWell(
                              onTap: () async {
                                print("Temp Language ${controller.languageName.value}");
                                await controller.changeLanguage(controller.languageName.value);
                                await controller.languageCache.write(AppString.languageSelect, controller.languageName.value);
                                Get.back();
                              },

                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                                  color: Color(0xff6ACC86),
                                ),
                                child: Text(
                                  'done'.tr,
                                  style: TextStyle(
                                    color: Color(0xFFffffff),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                                  color: Color(0xff2BA6CE),
                                ),
                                child: Text(
                                  'cancel'.tr,
                                  style: TextStyle(
                                    color: Color(0xFFffffff),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'change'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF61C7C4),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],),
            ),

            SizedBox(height: 10,),
            Obx(
                  () => Container(
                height: 54,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.appBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Row(children: [
                  Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xff41918B),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Image(image: AssetImage('assets/images/notification_icon.png'),height: 18,width: 18,)
                  ),
                  SizedBox(width: 8,),
                  Text(
                    'notification'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.59,
                    ),
                  ),
                  Spacer(),
                  Text(
                    controller.canNotify.value == true ? 'On' : 'Off',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.59,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.9,
                    child: Switch(
                        value: controller.canNotify.value,
                        onChanged: (value) {
                          // final action = await Dialogs.generalDialog(context,
                          //     "If you turn off your notifications, you won't receive any updates when your mining session expires.");
                          controller.canNotify.value = value;
                          controller.updateNotification(
                              update: value, context: context);
                        }),
                  )
                ],),
              ),
            ),
            SizedBox(height: 10,),
            Obx(
                  () => Container(
                height: 54,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.appBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Row(children: [
                  Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xff41918B),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Image(image: AssetImage('assets/images/notification_icon.png'),height: 18,width: 18,)
                  ),
                  SizedBox(width: 8,),
                  Text(
                    'Offline Widget',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.59,
                    ),
                  ),
                  Spacer(),
                  Text(
                    controller.isNetworkWidgetOn.value == true ? 'On' : 'Off',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.59,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.9,
                    child: Switch(
                        value: controller.isNetworkWidgetOn.value,
                        onChanged: (value) async {
                          // final action = await Dialogs.generalDialog(context,
                          //     "If you turn off your notifications, you won't receive any updates when your mining session expires.");

                          await controller.updateWidgetSettings(update: value);
                        }),
                  )
                ],),
              ),
            ),
            SizedBox(height: 10,),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.appBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xff41918B),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Icon(
                      Icons.delete_outlined,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'delete_account'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.59,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () async {
                      DialogsAction action1 =
                      await Dialogs.deleteACDialog(context);
                      Future.value(action1).then((value) async {
                        if (value.name == "yes") {
                          DialogsAction action =
                          await Dialogs.deleteConfirmation(context);
                          Future.value(action).then((value) async {
                            if (value.name == "yes") {
                              final action = await Dialogs.generalDialog(
                                  context,
                                  "Your account deletion request has been received. It will be processed within 90 days. Remember, once deleted, accounts cannot be recovered. We are not liable for any loss resulting from this action.");
                              Future.value(action).then((value) async {
                                if (value.name == "yes") {
                                  print("delete account");

                                  controller.deleteAccount();
                                }
                              });
                            }
                          });
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Color(0x1A61C7C4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'Submit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF61C7C4),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () async {
                controller.logout();
              },
              child: Center(
                child: Container(
                  width: Get.width / 3,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(0xffFFD1C7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        color: Color(0xffFF6543),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'logout'.tr,
                        style: TextStyle(
                          color: Color(0xFFFF6442),
                          fontSize: 12.66,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.23,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],

        ),
      )),
      drawer:  HomeDrawer(),
    );
  }

  void _copyToClipboard(String text, context) {
    FlutterClipboard.copy(text).then((value) {
      // Optionally, you can show a message to indicate that the text has been copied.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('text_copied'.tr)),
      );
    });
  }


  _selectLanguage(context){
    return showDialog(context: context, builder: (context){
      return LanguagePickerDialog(
          title: Text('select_language'.tr),
          isSearchable: true,
          searchInputDecoration: InputDecoration(hintText: "Search"),
          onValuePicked: (Language language){
            controller.language.value = language.name;
            controller.languageCode.value = language.isoCode;
          },
          itemBuilder: (Language language){
            return Row(
              children: [
                Text(language.name),
                SizedBox(width: 8),
                Text('(${language.isoCode})'),
              ],
            );
          });
    });
  }
}