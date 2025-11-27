import 'dart:ffi';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../colors/app_colors.dart';
import '../../controllers/profile_controller.dart';
import '../widgets/home_drawer.dart';
import 'profile_faq_page.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  ProfilePage({super.key});

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
          "profile".tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.59,
          ),
        ),
        actions: [
          InkWell(
            onTap: (){
              Get.to(() => const ProfileFaqPage());
            },
            child: Row(children: [
              Icon(Icons.quiz, color: Colors.white,),
              SizedBox(width: 5,),
              Text('FAQ', style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.59,
              ),),
              SizedBox(width: 15,),
            ],),
          ),
        ],
      ),
      body: Container(
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
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image(
                  image: AssetImage('assets/images/user_id_icon.png'),
                  height: 18,
                  width: 27,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  'user_id'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.36,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.appBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Obx(
                            () => Text(
                          controller.userId.value ?? "",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.40),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        _copyToClipboard(controller.userId.value, context);
                      },
                      child: Icon(
                        Icons.copy_rounded,
                        color: Colors.white.withOpacity(0.40),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  'full_name'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.36,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.appBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
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
                  InkWell(
                    onTap: () async {
                      showDialog(context: context, builder: ( ctx){
                        return AlertDialog(
                          backgroundColor: AppColors.appBackgroundColor,
                          title:  Text(
                            'change_name'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.36,
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: "Warning: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: "You can change your 'Name' only once. After that, changes require email approval with documents. Choose carefully!"),
                                  ],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.59,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.appSecondaryBackgroundColor,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: controller.fullNameController,
                                        style: TextStyle(color: Colors.white),
                                        onChanged: (value) {
                                          controller.nameVisible.value = false;
                                        },
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
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Obx(
                                    () => Visibility(
                                    visible: controller.nameVisible.value,
                                    child: Text('Name is empty.', style: TextStyle(color: Colors.red),)),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Obx(
                                        () => Checkbox(
                                        visualDensity: VisualDensity(horizontal: -4.0),
                                        value: controller.isConfirmIdentity.value, onChanged: (value){
                                      controller.isConfirmIdentity.value = value!;
                                      if(controller.isConfirmIdentity.value){
                                        controller.visibleIdentity.value = false;
                                      } else {
                                        controller.visibleIdentity.value = true;
                                      }
                                    }),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        controller.isConfirmIdentity.value = !controller.isConfirmIdentity.value;
                                        if(controller.isConfirmIdentity.value){
                                          controller.visibleIdentity.value = false;
                                        } else {
                                          controller.visibleIdentity.value = true;
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'I confirm that I am providing my name based on my identity.',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.84,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.45,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5,),
                              Obx(
                                    () => Visibility(
                                    visible: controller.visibleIdentity.value,
                                    child: Text('You must confirm your identity.', style: TextStyle(color: Colors.red),)),
                              ),
                            ],
                          ),
                          actions: [
                            InkWell(
                              onTap:() async {
                                if(controller.fullNameController.text.trim() != "") {
                                  if(controller.isConfirmIdentity.value) {
                                    Navigator.of(ctx).pop();
                                    await controller.updateName(context,
                                        controller.fullNameController.text);
                                  } else{
                                    controller.visibleIdentity.value = true;
                                  }
                                } else{
                                  controller.nameVisible.value = true;
                                }
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
                            )
                          ],
                        );
                      });
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
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.phone_android,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  'phone_no'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),


            Container(
              height: 54, // Adjusted height to match the second text field
              padding: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                color: AppColors.appBackgroundColor,
                // Use the background color from the second text field
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                children: [
                  Container(
                    width: Get.width - 85,
                    height: 53,
                    child: Obx(() =>
                        InternationalPhoneNumberInput(
                          autoValidateMode: AutovalidateMode.disabled,
                          isEnabled: false,
                          textStyle: TextStyle(
                            color: Colors.white,
                          ),
                          selectorTextStyle: TextStyle(
                            color: Color(0xff777777),
                          ),
                          inputDecoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          inputBorder: InputBorder.none,
                          onInputChanged: (PhoneNumber number) {
                            // print(number
                            //  .phoneNumber); // Handle phone number input
                            // controller.phoneNumberString.value =
                            // number.phoneNumber!;
                            // controller.setAllDataValidated();
                          },
                          onInputValidated: (bool value) {
                            print(value); // Validate phone number
                          },
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DROPDOWN,
                          ),
                          initialValue: PhoneNumber(
                              isoCode: controller.countryCode.value,
                              phoneNumber: controller.phoneNumberString.value),
                        )),
                  ),
//                   InkWell(
//                     onTap: () async {
//                       Get.dialog(Container(
//                         width: Get.width,
//                         padding: EdgeInsets.symmetric(vertical: 16),
//                         margin: EdgeInsets.symmetric(
//                             horizontal: 20, vertical: Get.height * 0.32),
//                         decoration: BoxDecoration(
//                             color: AppColors.appBackgroundColor,
//                             borderRadius: BorderRadius.circular(10.0)),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               "change_phone".tr,
//                               style: TextStyle(
//                                 fontFamily: 'Poppins',
//                                 color: Colors.white,
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 16),
//                               child: RichText(
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(text: "Warning: ", style: TextStyle(fontWeight: FontWeight.bold)),
//                                     TextSpan(text: "You can change your 'Phone' only once. After that, changes cannot be done. Choose carefully!"),
//                                   ],
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 13,
//                                     fontStyle: FontStyle.italic,
//                                     fontFamily: 'Poppins',
//                                     fontWeight: FontWeight.w300,
//                                     letterSpacing: 0.59,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Form(
//                               key: controller.formKeyPhoneNo,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: AppColors.appTextFieldColor,
//                                     borderRadius: BorderRadius.circular(10.0)),
//                                 width: Get.width - 60,
//                                 height: 60,
//                                 child: InternationalPhoneNumberInput(
//                                   autoValidateMode: AutovalidateMode.disabled,
//                                   textStyle: TextStyle(
//                                     color: Colors.white,
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "please_enter_phone".tr;
//                                     }
//                                   },
//                                   selectorTextStyle: TextStyle(
//                                     color: Color(0xff777777),
//                                   ),
//                                   inputDecoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintStyle: TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   inputBorder: InputBorder.none,
//                                   onInputChanged: (PhoneNumber number) {
//                                     controller.phoneNumberString.value = "${number.isoCode},${number.phoneNumber}";
//                                     controller.setAllDataValidated();
//                                     print("Dial Code ${controller.phoneNumberString.value}");
//                                   },
//                                   onInputValidated: (bool value) {
//                                     print(value); // Validate phone number
//                                   },
//                                   selectorConfig: SelectorConfig(
//                                     selectorType:
//                                     PhoneInputSelectorType.DROPDOWN,
//                                   ),
//                                   initialValue: PhoneNumber(
//                                       isoCode: controller.countryCode.value,
//                                       phoneNumber: controller
//                                           .phoneNumberString.value),
//                                 ),
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     if (controller.formKeyPhoneNo.currentState!
//                                         .validate()) {
//                                       controller.updatePhoneno(
//                                         context,
//                                         controller.phoneNumberString.value,
//                                       );
//                                       Navigator.of(context).pop();
//                                     }
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(25)),
//                                       color: Color(0xff6ACC86),
//                                     ),
//                                     child: Text(
//                                       'done'.tr,
//                                       style: TextStyle(
//                                         color: Color(0xFFffffff),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: () async {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(25)),
//                                       color: Color(0xff2BA6CE),
//                                     ),
//                                     child: Text(
//                                       'cancel'.tr,
//                                       style: TextStyle(
//                                         color: Color(0xFFffffff),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ));
// /**/
//                     },
//                     child: Text(
//                       'change'.tr,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Color(0xFF61C7C4),
//                         fontSize: 12,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   )
                ],
              ),
            ),



            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  'email_address'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 55,
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              decoration: BoxDecoration(
                color: AppColors.appBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      onChanged: (v) {},
                      controller: controller.emailController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.lock_outline),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  'password'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 55,
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              decoration: BoxDecoration(
                color: AppColors.appBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      obscureText: true,
                      onChanged: (v) {},
                      controller: controller.passwordController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
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
                              "change_password".tr,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: Container(
                                height: 400,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.lock_outline,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          'old_password'.tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Obx(
                                          () => Form(
                                        key: controller.formKeyOldPass,
                                        // Use a different key for the old password
                                        child: TextFormField(
                                          controller:
                                          controller.oldPasswordController,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                          onChanged: (value) {
                                            controller
                                                .formKeyOldPass.currentState!
                                                .validate();
                                            controller.setAllDataValidated();
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "enter_old_password".tr;
                                            }
                                            // Your validation logic for the old password
                                          },
                                          obscureText: controller
                                              .isPasswordVisibleOldPass.value,
                                          decoration: InputDecoration(
                                            fillColor:
                                            AppColors.appTextFieldColor,
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                            ),
                                            suffixIcon: InkWell(
                                              onTap: () {
                                                controller
                                                    .isPasswordVisibleOldPass
                                                    .value =
                                                !controller
                                                    .isPasswordVisibleOldPass
                                                    .value;
                                              },
                                              child: Obx(
                                                    () => Icon(
                                                  controller
                                                      .isPasswordVisibleOldPass
                                                      .value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.lock_outline,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          'new_password'.tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Obx(
                                          () => Form(
                                        key: controller.formKeyNewPass,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            TextFormField(
                                              controller: controller
                                                  .newPasswordController,
                                              scrollPadding: EdgeInsets.zero,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                              obscureText: controller
                                                  .isPasswordVisibleNewPass
                                                  .value,
                                              onChanged: (value) {
                                                controller.formKeyNewPass
                                                    .currentState!
                                                    .validate();
                                                //  controller.setAllDataValidated();
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "enter_password".tr;
                                                } else {
                                                  //call function to check password
                                                  bool result = controller
                                                      .validatePassword(value);
                                                  if (result) {
                                                    // create account event
                                                    controller.newPasswordString
                                                        .value = value;
                                                    return null;
                                                  } else {
                                                    return " ${'password_should_contain'.tr}";
                                                  }
                                                }
                                              },
                                              decoration: InputDecoration(
                                                fillColor:
                                                AppColors.appTextFieldColor,
                                                filled: true,
                                                suffixIcon: InkWell(
                                                  onTap: () {
                                                    controller
                                                        .isPasswordVisibleNewPass
                                                        .value =
                                                    !controller
                                                        .isPasswordVisibleNewPass
                                                        .value;
                                                  },
                                                  child: Obx(
                                                        () => Icon(
                                                      controller
                                                          .isPasswordVisibleNewPass
                                                          .value
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(12)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(12.0),
                                              child: LinearProgressIndicator(
                                                value: controller
                                                    .password_strength.value,
                                                backgroundColor:
                                                Colors.grey[300],
                                                minHeight: 5,
                                                color: controller
                                                    .password_strength
                                                    .value <=
                                                    1 / 4
                                                    ? Colors.red
                                                    : controller.password_strength
                                                    .value ==
                                                    2 / 4
                                                    ? Colors.yellow
                                                    : controller.password_strength
                                                    .value ==
                                                    3 / 4
                                                    ? Colors.blue
                                                    : Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.lock_outline,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          'confirm_password'.tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Obx(
                                          () => Form(
                                        key: controller.formKeyConfirmPass,
                                        child: TextFormField(
                                          controller:
                                          controller.confirmPassController,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                          onChanged: (value) {
                                            controller.formKeyConfirmPass
                                                .currentState!
                                                .validate();
                                            controller.setAllDataValidated();
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter password";
                                            } else {
                                              //call function to check password
                                              if (value ==
                                                  controller.newPasswordString
                                                      .value) {
                                                // create account event
                                                controller.isNewPasswordsMatched
                                                    .value = true;
                                                return null;
                                              } else {
                                                controller.isNewPasswordsMatched
                                                    .value = false;
                                                return "password_not_matched".tr;
                                              }
                                            }
                                          },
                                          obscureText: controller
                                              .isPasswordVisibleConfirmPass
                                              .value,
                                          decoration: InputDecoration(
                                            fillColor:
                                            AppColors.appTextFieldColor,
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                            ),
                                            suffixIcon: InkWell(
                                              onTap: () {
                                                controller
                                                    .isPasswordVisibleConfirmPass
                                                    .value =
                                                !controller
                                                    .isPasswordVisibleConfirmPass
                                                    .value;
                                              },
                                              child: Obx(
                                                    () => Icon(
                                                  controller
                                                      .isPasswordVisibleConfirmPass
                                                      .value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              InkWell(
                                onTap: () {
                                  if (controller.formKeyOldPass.currentState!.validate() &&
                                      controller.formKeyNewPass.currentState!
                                          .validate() &&
                                      controller
                                          .formKeyConfirmPass.currentState!
                                          .validate()) {
                                    controller.updatePassword(
                                        context,
                                        controller.oldPasswordController,
                                        controller.newPasswordController);
                                    Navigator.of(context).pop();
                                  }
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
                ],
              ),
            ),
            SizedBox(height: 10),
            // Row(
            //   children: [
            //     Icon(
            //       Icons.language,
            //       color: Colors.white,
            //       size: 18,
            //     ),
            //     SizedBox(
            //       width: 3,
            //     ),
            //     Text(
            //       'language'.tr,
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 15,
            //         fontFamily: 'Poppins',
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // Container(
            //   height: 50,
            //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            //   decoration: BoxDecoration(
            //     color: AppColors.appBackgroundColor,
            //     borderRadius: BorderRadius.all(Radius.circular(25)),
            //   ),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: TextField(
            //           readOnly: true,
            //           onChanged: (v) {},
            //           controller: controller.languageController,
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 15,
            //             fontFamily: 'Poppins',
            //             fontWeight: FontWeight.w500,
            //           ),
            //           decoration: InputDecoration(
            //             suffixIcon: Icon(Icons.lock_outline),
            //             border: InputBorder.none,
            //           ),
            //         ),
            //       ),
            //       InkWell(
            //         onTap: () async {
            //           await showDialog(
            //             context: context,
            //             barrierDismissible: true,
            //             builder: (BuildContext context) {
            //               return AlertDialog(
            //                 contentPadding: EdgeInsets.all(16.0),
            //                 actionsPadding: EdgeInsets.all(16.0),
            //                 // Adjust padding as needed
            //
            //                 backgroundColor: AppColors.appBackgroundColor,
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(10.0)),
            //                 title: Text(
            //                   "change_language".tr,
            //                   style: TextStyle(
            //                     fontFamily: 'Poppins',
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //                 content: Obx(
            //                   () => DropdownButton(
            //                     value: controller.languageName.value,
            //                     underline: Container(
            //                       height: 2,
            //                       color: Colors.white,
            //                     ),
            //                     onChanged: (value){
            //                       controller.languageController.text = value!;
            //                       controller.languageName.value = value;
            //                     },
            //                     items: [
            //                       DropdownMenuItem<String>(
            //                           value: "English",
            //                           child: Text('English', style: TextStyle(color: Colors.white),),
            //                       ),
            //                       DropdownMenuItem<String>(
            //                           value: "Bangla",
            //                           child: Text('Bangla', style: TextStyle(color: Colors.white)),
            //                       ),
            //                       DropdownMenuItem<String>(
            //                           value: "Hindi",
            //                           child: Text('Hindi', style: TextStyle(color: Colors.white)),
            //                       ),
            //                       DropdownMenuItem<String>(
            //                           value: "French",
            //                           child: Text('French', style: TextStyle(color: Colors.white)),
            //                       ),
            //                       DropdownMenuItem<String>(
            //                           value: "Chinese",
            //                           child: Text('Chinese', style: TextStyle(color: Colors.white)),
            //                       ),
            //                       DropdownMenuItem<String>(
            //                         value: "Nigerian",
            //                         child: Text('Nigerian', style: TextStyle(color: Colors.white)),
            //                       ),
            //                       DropdownMenuItem<String>(
            //                         value: "Urdu",
            //                         child: Text('Urdu', style: TextStyle(color: Colors.white)),
            //                       ),
            //                       DropdownMenuItem<String>(
            //                         value: "Vietnamese",
            //                         child: Text('Vietnamese', style: TextStyle(color: Colors.white)),
            //                       ),
            //                       DropdownMenuItem<String>(
            //                         value: "Filipino",
            //                         child: Text('Filipino', style: TextStyle(color: Colors.white)),
            //                       ),
            //                       DropdownMenuItem<String>(
            //                         value: "Indonesian",
            //                         child: Text('Indonesian', style: TextStyle(color: Colors.white)),
            //                       ),
            //                       DropdownMenuItem<String>(
            //                         value: "Spanish",
            //                         child: Text('Spanish', style: TextStyle(color: Colors.white)),
            //                       ),
            //                       DropdownMenuItem<String>(
            //                         value: "German",
            //                         child: Text('German', style: TextStyle(color: Colors.white)),
            //                       ),
            //                       DropdownMenuItem<String>(
            //                         value: "Arabic",
            //                         child: Text('Arabic', style: TextStyle(color: Colors.white)),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 actions: <Widget>[
            //                   InkWell(
            //                     onTap: () async {
            //                     await controller.changeLanguage(controller.languageController.text);
            //                     await controller.languageCache.write(AppString.languageSelect, controller.languageController.text);
            //                     Get.back();
            //                     },
            //
            //                     child: Container(
            //                       padding: EdgeInsets.all(10),
            //                       decoration: BoxDecoration(
            //                         borderRadius:
            //                         BorderRadius.all(Radius.circular(25)),
            //                         color: Color(0xff6ACC86),
            //                       ),
            //                       child: Text(
            //                         'done'.tr,
            //                         style: TextStyle(
            //                           color: Color(0xFFffffff),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   InkWell(
            //                     onTap: () async {
            //                       Navigator.of(context).pop();
            //                     },
            //                     child: Container(
            //                       padding: EdgeInsets.all(10),
            //                       decoration: BoxDecoration(
            //                         borderRadius:
            //                         BorderRadius.all(Radius.circular(25)),
            //                         color: Color(0xff2BA6CE),
            //                       ),
            //                       child: Text(
            //                         'cancel'.tr,
            //                         style: TextStyle(
            //                           color: Color(0xFFffffff),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               );
            //             },
            //           );
            //         },
            //         child: Text(
            //           'change'.tr,
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             color: Color(0xFF61C7C4),
            //             fontSize: 12,
            //             fontFamily: 'Poppins',
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            SizedBox(height: 15,),
          ],
        ),
      ),
      drawer: HomeDrawer(),
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
}