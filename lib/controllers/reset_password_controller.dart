import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../common/app_loading.dart';
import '../common/global_widget.dart';
import '../data/repo/repo.dart';
import '../views/pages/login_page.dart';

class ResetPasswordController extends GetxController{

  TextEditingController resetEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final formKeyNewPass = GlobalKey<FormState>();
  final formKeyConfirmPass = GlobalKey<FormState>();
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  RegExp emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  var password_strength = 0.0.obs;
  var newPasswordString = "".obs;
  var isPasswordVisibleNewPass = true.obs;
  var isPasswordVisibleConfirmPass = true.obs;
  var isNewPasswordsMatched = false.obs;
  var passwordSave = false.obs;
  var isAllDataFilled = false.obs;

  var isPasswordValid = false.obs;

  var recaptchaRefresh = false.obs;

  bool validatePassword(String pass){
    String _password = pass.trim();
    if(_password.isEmpty){
      password_strength.value = 0;
    }else if(_password.length < 6 ){
      password_strength.value = 1 / 4;
    }else if(_password.length < 8){
      password_strength.value = 2 / 4;
    }else{
      if(pass_valid.hasMatch(_password)){
        password_strength.value = 4 / 4;
        return true;
      }else{
        password_strength.value = 3 / 4;
        return false;
      }
    }
    return false;
  }


  void setAllDataValidated(){
    if(isNewPasswordsMatched.value &&
        resetEmailController.text.isNotEmpty &&
        validatePassword(newPasswordString.value)){
      isAllDataFilled.value = true;
    } else{
      isAllDataFilled.value = false;
    }
  }

  bool validateEmail(String email) {
    // Trim whitespace from email
    email = email.trim();

    // Allow letters, numbers, periods (.), underscores (_), and @
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9._]+\.[a-zA-Z]+$');

    // Check if the email matches the regex
    return emailRegex.hasMatch(email);
  }



  resetPassword({
    required String email,
    required String newpassword,
  }) async {
    setAllDataValidated();
    if (isAllDataFilled.value){
      try {
        showLoading();
        await UserRepo.getInstance().resetPassword(
          data: {
            "email": email.trim(),
            "newPassword": newpassword,
          },
        ).then((response) {
          response.fold((l) {
            errorSnack(l.errorMessage.toString());

            hideLoading();
          }, (r) async {
            print("SAKIB Reset: ${r.result}");
            if (r.result != null) {
              String resetSnack = "Your password reset request was successful! Please check your email (including spam folder) for the verification link. Once clicked, you can access the Orbaic portal with your new password.";
              Get.off(() => LoginPage());
              successSnack(resetSnack);
            }
          });
        });
      } catch (e) {
        errorSnack("$e");
      }
      finally {
        hideLoading();
      }
    } else if(newPasswordController.text != confirmPassController.text){
      // String errorString = "Password is weak. You can not submit.";
      String errorString = "Password not matched.";
      errorSnack(errorString);
    }

    else{
      // String errorString = "Password is weak. You can not submit.";
      String errorString = "Password is weak. Add special char, numbers, and alphabetic.";
      errorSnack(errorString);
    }
  }



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}