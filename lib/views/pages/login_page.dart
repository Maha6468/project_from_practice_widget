import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_from_practice_widget/views/pages/register_page.dart';
import 'package:project_from_practice_widget/views/pages/reset_passsword_page.dart';

import '../../colors/app_colors.dart';
import '../../common/global_widget.dart';
import '../../common/string.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/dialogs.dart';
import '../widgets/pw_validator.dart';

class LoginPage extends GetView<AuthController> {
  LoginPage({Key? key}) : super(key: key);


  final AuthController controller = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            height: Get.height,
            padding: EdgeInsets.all(24),
            color: AppColors.appBackgroundColor,
            child: Center(
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
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
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'welcome_back'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.16,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: Colors.white,
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

                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: BoxDecoration(
                      color: AppColors.appTextFieldColor,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: TextField(
                      controller: controller.loginEmailController,
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
                  SizedBox(height: 10),
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
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.appTextFieldColor,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Obx(
                          () => TextField(
                        controller: controller.loginPasswordController,
                        onChanged: controller.validatePassword,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        obscureText: !controller.isPasswordVisibleLogin.value,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.appTextFieldColor,
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: AppColors.appTextFieldColor),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: AppColors.appTextFieldColor),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              controller.isPasswordVisibleLogin.value =
                              !controller.isPasswordVisibleLogin.value;
                            },
                            child: Obx(
                                  () => Icon(
                                controller.isPasswordVisibleLogin.value
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
                  SizedBox(height: 10),
                  PwValidator(
                    controller: controller.loginPasswordController,
                    onValidate: (value) {
                      controller.isPasswordValid(value);
                    },
                  ),
                  Row(
                    children: [
                      Obx(
                            () => Checkbox(
                            visualDensity: VisualDensity(horizontal: -4.0),
                            value: controller.passwordSave.value,
                            onChanged: (value) {
                              controller.passwordSave.value = value!;
                            }),
                      ),
                      Text(
                        'save_password'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.84,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.45,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.to(() => ResetPasswordPage());
                        },
                        child: Text(
                          'forgot_password'.tr,
                          style: TextStyle(
                            color: Color(0xFF64D2FF),
                            fontSize: 12.84,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.45,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      FirebaseAnalytics.instance.logEvent(
                        name: 'login_button_click',
                        parameters: {'button_name': 'login_button'},
                      );

                      String password = controller.loginPasswordController.text;
                      String email = controller.loginEmailController.text;
                      bool test = false;
                      if(!controller.validateEmail(email)){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Email Invalid. Please enter a valid email. Only latters (a-z), numbers(0-9), periods (.) and @ are allowed.')));
                        return;
                      }
                      if (!controller.isPasswordValid.value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Password Invalid. Please enter a valid password.')));
                        return;
                      }
                      if (_formKey.currentState!.validate()) {
                        if (await ConnectivityWrapper.instance.isConnected) {
                          controller.login(email: email.toLowerCase(), password: password);
                        } else {
                          warningSnack(AppString.pleaseCheckYourInternet);
                        }
                        test = true;
                      } else {
                        errorSnack("Please enter valid email and password");
                        // final action = await Dialogs.resetPasswordDialog(context);
                        // if (action == DialogsAction.yes) {
                        //   // Do something if the user pressed 'yes' in the dialog
                        // } else {
                        //   // Do something if the user pressed 'no' in the dialog
                        // }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xff61C7C4), Color(0xff333E53)]),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Center(
                        child: Text(
                          'login'.tr,
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
                  SizedBox(
                    height: 15,
                  ),
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
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (await ConnectivityWrapper.instance.isConnected) {
                            await controller.signInWithGoogle();
                          } else {
                            warningSnack(AppString.pleaseCheckYourInternet);
                          }
                          /*   if (true) {
                           GoogleSignInAccount? account = await controller.signInWithGoogle();
                           GoogleSignInAuthentication? s = await account?.authentication;

                           if(account != null){
                             print("Sakib Checking Google Email: ${account.email}");
                             print("Sakib Checking Google Name: ${account.displayName}");
                             print("Sakib Checking Google Id: ${account.id}");
                             print("Sakib Checking Google Token: ${s?.accessToken}");
                           } else{
                             print("Google Account is null");
                           }
                          //  User? user = await controller.signInWithGoogle();
                          // print('Sakib Check Google User: ${user?.email}');
                          }*/

                        },
                        child: Container(
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              color: Colors.white),
                          child: Image(
                            fit: BoxFit.contain,
                            image:
                            AssetImage('assets/images/google_icon.png'),
                            height: 42,
                            width: 42,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          // bool check = await controller.signInWithGoogle();
                          if (true) {
                            controller.appleLogin();
                          }
                        },
                        child: Visibility(
                          visible: false,
                          child: Container(
                            padding: EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            child: Image(
                              fit: BoxFit.contain,
                              image:
                              AssetImage('assets/images/apple_icon.png'),
                              height: 42,
                              width: 42,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
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
                        onTap: () {
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
                  SizedBox(height: 50,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}