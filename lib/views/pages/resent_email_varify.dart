import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:slider_captcha/slider_captcha.dart';

import '../../colors/app_colors.dart';
import '../../common/global_widget.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/dialogs.dart';
import '../widgets/pw_validator.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        padding: EdgeInsets.symmetric(horizontal: 24),
        color: AppColors.appBackgroundColor,
        child: Center(
          child: ListView(
            children: [
              SizedBox(height: 44,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/orbaic_logo.png'),
                    width: Get.width * 2 / 3,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text(
                'register_now'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.16,
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Icon(Icons.person, color: Colors.white,),
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColors.appTextFieldColor,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextField(
                  onChanged: (v){
                    controller.setAllDataValidated();
                  },
                  controller: controller.registerFullNameController,
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
              SizedBox(height: 15,),
              Row(
                children: [
                  Icon(Icons.phone_android, color: Colors.white,),
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
              SizedBox(height: 3,),
              Container(
                height: 60,
                padding: EdgeInsets.only(top: 5, bottom: 5, right: 15),
                decoration: BoxDecoration(
                  color: AppColors.appTextFieldColor,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: Get.width - 70,
                      height: 60,
                      child: FutureBuilder(
                          future: controller.getLocation(),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return Center(child: CircularProgressIndicator());
                            }
                            return InternationalPhoneNumberInput(
                              keyboardType: TextInputType.numberWithOptions(signed: false,),
                              textStyle: TextStyle(
                                  color: Colors.white
                              ),
                              selectorTextStyle: TextStyle(
                                color: Color(0xff777777),
                              ),
                              inputDecoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.white
                                  )
                              ),
                              inputBorder: InputBorder.none,
                              onInputChanged: (PhoneNumber number) {// Handle phone number input
                                controller.phoneNumberString.value = "${number.isoCode},${number.phoneNumber}";
                                controller.setAllDataValidated();
                                print("Dial Code ${controller.phoneNumberString.value}");
                              },
                              onInputValidated: (bool value) {
                                print(value); // Validate phone number
                              },
                              selectorConfig: SelectorConfig(
                                selectorType: PhoneInputSelectorType.DROPDOWN,
                              ),
                              initialValue: PhoneNumber(isoCode: controller.countryCode.value),
                            );
                          }
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Icon(Icons.email_outlined, color: Colors.white,),
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
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColors.appTextFieldColor,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextField(
                  onChanged: (v){
                    controller.setAllDataValidated();
                  },
                  controller: controller.registerEmailController,
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
              SizedBox(height: 10,),

              Row(
                children: [
                  Icon(Icons.lock_outline, color: Colors.white,),
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
              SizedBox(height: 5,),
              Obx(
                    () => Form(
                  key: controller.formKeyPass,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: controller.registerPasswordController,
                        scrollPadding: EdgeInsets.zero,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        obscureText: controller.isPasswordVisibleRegPass.value,
                        onChanged: (value){
                          controller.formKeyPass.currentState!.validate();
                          controller.setAllDataValidated();
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return "enter_password".tr;
                          }else{
                            //call function to check password
                            bool result = controller.validatePassword(value);
                            if(result){
                              // create account event
                              controller.registerPasswordString.value = value;
                              controller.setAllDataValidated();
                              return null;
                            }else{
                              return "password_should_contain".tr;
                            }
                          }
                        },
                        decoration: InputDecoration(
                          fillColor: AppColors.appTextFieldColor, filled: true,
                          suffixIcon: InkWell(
                            onTap: (){
                              controller.isPasswordVisibleRegPass.value = !controller.isPasswordVisibleRegPass.value;
                            },
                            child: Obx(
                                  () => Icon(
                                controller.isPasswordVisibleRegPass.value ? Icons.visibility_off :
                                Icons.visibility,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(12.0),
                      //   child: LinearProgressIndicator(
                      //     value: controller.password_strength.value,
                      //     backgroundColor: Colors.grey[300],
                      //     minHeight: 5,
                      //     color: controller.password_strength.value <= 1 / 4
                      //         ? Colors.red
                      //         : controller.password_strength.value == 2 / 4
                      //         ? Colors.yellow
                      //         : controller.password_strength.value == 3 / 4
                      //         ? Colors.blue
                      //         : Colors.green,
                      //   ),
                      // ),

                      SizedBox(height: 10),
                      PwValidator(
                        controller: controller.registerPasswordController,
                        onValidate: (value) {
                          controller.isPasswordValid(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Icon(Icons.lock_outline, color: Colors.white,),
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
              SizedBox(height: 5,),
              Obx(
                    () => Form(
                  key: controller.formKeyConfirmPass,
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (value){
                      controller.formKeyConfirmPass.currentState!.validate();
                      controller.setAllDataValidated();
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "enter_password".tr;
                      }else{
                        //call function to check password
                        if(value == controller.registerPasswordString.value){
                          // create account event
                          controller.isRegisterPasswordsMatched.value = true;
                          controller.setAllDataValidated();
                          return null;

                        }else{
                          controller.isRegisterPasswordsMatched.value = false;
                          controller.setAllDataValidated();
                          return "password_not_matched".tr;
                        }

                      }

                    },
                    obscureText: controller.isPasswordVisibleRegConfirmPass.value,
                    decoration: InputDecoration(
                      fillColor: AppColors.appTextFieldColor, filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      suffixIcon: InkWell(
                        onTap: (){
                          controller.isPasswordVisibleRegConfirmPass.value = !controller.isPasswordVisibleRegConfirmPass.value;
                        },
                        child: Obx(
                              () => Icon(
                            controller.isPasswordVisibleRegConfirmPass.value ? Icons.visibility_off :
                            Icons.visibility,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),

              Row(
                children: [
                  Obx(
                        () => Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0),
                        value: controller.isTermsAndPolicyAccepted.value, onChanged: (value){
                      controller.isTermsAndPolicyAccepted.value = value!;
                      controller.setAllDataValidated();
                    }),
                  ),
                  Expanded(
                    child:Row(
                      children: [
                        Text(
                          'i_accept_all'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.84,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.45,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            String link = "https://orbaic.com/terms_condition.php";
                            final action = await Dialogs.leftAppDialog(context, link);
                          },
                          child: Text(
                            'terms_and_conditions'.tr,
                            style: TextStyle(
                              color: Color(0xFF64D2FF),
                              fontSize: 13.84,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.45,
                            ),
                          ),
                        ),
                        Text(
                          'of_orbaic'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.50,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.45,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: () {
                  if (!controller.isAllDataFilled.value) {
                    return;
                  }
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext ctx) {
                      var sc = SliderController();
                      var rnd = Random();
                      return Dialog(
                        backgroundColor: AppColors.appBackgroundColor,
                        child: SizedBox(
                          width: double.maxFinite,
                          height: 275,
                          child: Obx(() => CachedNetworkImage(
                            imageUrl: "https://www.orbaic.com/captcha/captcha_img.php?q=${rnd.nextInt(100)}&is=${controller.recaptchaRefresh.value}",
                            imageBuilder: (_, imageProvider) => SliderCaptcha(
                              controller: sc,
                              image: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      colorFilter:
                                      ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                                ),
                              ),
                              colorBar: Color(0xff333E53),
                              colorCaptChar: Colors.blueGrey,
                              title: "Slide to Captcha",
                              titleStyle: TextStyle(
                                color: Colors.white,
                              ),
                              onConfirm: (value) async {
                                Future.delayed(const Duration(seconds: 1));
                                controller.recaptchaRefresh(!controller.recaptchaRefresh.value);
                                if (value) {
                                  Navigator.of(ctx).pop();
                                  _goRegister(context);
                                }
                              },
                            ),
                            placeholder: (context, url) => Container(
                              width: double.maxFinite,
                              height: 275,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          )),
                        ),
                      );
                    },
                  );
                },
                child: Obx(
                      () => Container(
                    padding: EdgeInsets.all(12),
                    decoration: controller.isAllDataFilled.value ? BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
                          colors: [Color(0xff61C7C4), Color(0xff333E53)]),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ): BoxDecoration(
                      color: Color(0xffC0C0C0),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: Text(
                        'register'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.54,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),

              Text(
                'register_with'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.16,
                ),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      await controller.signInWithGoogle();
                    },
                    child: Container(
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white
                        ),
                        child: Image(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/google_icon.png'), height: 42,
                          width: 42,)
                    ),
                  ),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: () async {
                      // bool check = await controller.signInWithGoogle();
                      if(true){
                        controller.appleLogin();
                      }
                    },
                    child: Visibility(
                      visible: false,
                      child: Container(
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white
                          ),
                          child: Image(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/apple_icon.png'), height: 42,
                            width: 42,)
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'already_have_account'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.84,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.45,
                          ),
                        ),
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Color(0xFF2BA6CE),
                            fontSize: 14.84,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.45,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(() => LoginPage());
                    },
                    child: Text(
                      'login'.tr,
                      style: TextStyle(
                        color: Color(0xFF64D2FF),
                        fontSize: 14.84,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.45,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100,),
            ],
          ),
        ),
      ),
    );
  }

  void _goRegister(BuildContext context) async {
    if(controller.isAllDataFilled.value){
      if(!controller.validateEmail(controller.registerEmailController.text.trim())){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email Invalid. Please enter a valid email. Only latters (a-z), numbers(0-9), periods (.) and @ are allowed.')));
        return;
      }
      if (!controller.isPasswordValid.value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password Invalid. Please enter a valid password.')));
        return;
      }
      if(!controller.isTermsAndPolicyAccepted.value){
        Get.snackbar("terms_and_policy".tr, "accept_policy".tr);
        return;
      }
      bool b = await controller.registerWithEmailAndPassword(context);
    }
  }

}