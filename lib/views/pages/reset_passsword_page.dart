import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_from_practice_widget/views/pages/register_page.dart';

import 'package:slider_captcha/slider_captcha.dart';
import '../../colors/app_colors.dart';
import '../../common/global_widget.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/reset_password_controller.dart';
import '../widgets/dialogs.dart';
import '../widgets/pw_validator.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});

  final ResetPasswordController controller = Get.put(ResetPasswordController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: Get.height,
          padding: EdgeInsets.symmetric(horizontal: 24),
          color: AppColors.appBackgroundColor,
          child: Center(
            child: ListView(
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/images/orbaic_logo.png'),
                      width: Get.width * 2 / 3,
                      height: 50,
                      fit: BoxFit.contain,),
                  ],
                ),
                SizedBox(height: 20,),
                Text(
                  'reset_password'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.16,
                  ),
                ),
                SizedBox(height: 20,),
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
                    controller: controller.resetEmailController,
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
                SizedBox(height: 5,),
                Obx(
                      () => Form(
                    key: controller.formKeyNewPass,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: controller.newPasswordController,
                          scrollPadding: EdgeInsets.zero,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                          obscureText: controller.isPasswordVisibleNewPass.value,
                          onChanged: (value){
                            controller.formKeyNewPass.currentState!.validate();
                            controller.setAllDataValidated();
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "please_enter_password".tr;
                            }else{
                              //call function to check password
                              bool result = controller.validatePassword(value);
                              if(result){
                                // create account event
                                controller.newPasswordString.value = value;
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
                                controller.isPasswordVisibleNewPass.value = !controller.isPasswordVisibleNewPass.value;
                              },
                              child: Obx(
                                    () => Icon(
                                  controller.isPasswordVisibleNewPass.value ? Icons.visibility_off :
                                  Icons.visibility,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),),
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
                          controller: controller.newPasswordController,
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
                      controller: controller.confirmPassController,
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
                          if(value == controller.newPasswordString.value){
                            // create account event
                            controller.isNewPasswordsMatched.value = true;
                            return null;

                          }else{
                            controller.isNewPasswordsMatched.value = false;
                            return "password_not_matched".tr;
                          }
                        }
                      },
                      obscureText: controller.isPasswordVisibleConfirmPass.value,
                      decoration: InputDecoration(
                        fillColor: AppColors.appTextFieldColor, filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        suffixIcon: InkWell(
                          onTap: (){
                            controller.isPasswordVisibleConfirmPass.value = !controller.isPasswordVisibleConfirmPass.value;
                          },
                          child: Obx(
                                () => Icon(
                              controller.isPasswordVisibleConfirmPass.value ? Icons.visibility_off :
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
                InkWell(
                  onTap: () async {
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
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
                          colors: [Color(0xff61C7C4), Color(0xff333E53)]),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: Text(
                        'reset'.tr,
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
                SizedBox(height: 15,),
                Text(
                  'login_with'.tr,
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
                        await authController.signInWithGoogle();
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
                        if(true){
                          generalErrorSnack("Apple login not available", "This feature is coming soon.");
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
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'not_have_account'.tr,
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
                        Get.to(() => RegisterPage());
                      },
                      child: Text(
                        'sign_up'.tr,
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
      ),
    );
  }

  void _goRegister(BuildContext context) async {
    String password = controller.newPasswordController.text;
    String email = controller.resetEmailController.text.trim();
    if(!controller.validateEmail(email)){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email Invalid. Please enter a valid email. Only latters (a-z), numbers(0-9), periods (.) and @ are allowed.'.tr)));
      return;
    }
    if (!controller.isPasswordValid.value) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password Invalid. Please enter a valid password.')));
      return;
    }

    if(password.trim().isNotEmpty && email.trim().isNotEmpty){
      await controller.resetPassword(email: email.toLowerCase(), newpassword: password);
    }
  }
}