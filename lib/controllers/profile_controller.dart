import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:project_from_practice_widget/controllers/profile_update_controller.dart';

import '../colors/app_colors.dart';
import '../common/app_loading.dart';
import '../common/firebase_notification/main dart configration.txt.dart' as PreferenceHelper;
import '../common/global_widget.dart';
import '../common/perfrance.dart';
import '../data/repo/repo.dart';
import '../models/profile_model.dart';
import '../models/update_profile_model.dart';
import '../views/pages/profile_faq_page.dart';
import '../views/pages/profile_update_page.dart';

class ProfileController extends GetxController{

  var registerPasswordString = "".obs;
  var isRegisterPasswordsMatched = false.obs;
  var isPasswordVisibleRegConfirmPass = true.obs;

  final formKeyPass = GlobalKey<FormState>();
  var isPasswordVisibleRegPass = true.obs;
  var isPasswordVisibleLogin = true.obs;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isConfirmIdentity = false.obs;
  var profileModel = Rx<ProfileModel?>(null);
  var updateProfileModel = Rx<UpdateProfileModel?>(null);
  var userId = "".obs;
  var refCode = "".obs;
  var fullName="".obs;
  var phoneNo="".obs;
  var password="*******".obs;
  var country = "".obs;
  var countryCode = "US".obs;

  TextEditingController resetEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final formKeyNewPass = GlobalKey<FormState>();
  final formKeyConfirmPass = GlobalKey<FormState>();
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  var password_strength = 0.0.obs;
  var newPasswordString = "".obs;
  var isPasswordVisibleNewPass = true.obs;
  var isPasswordVisibleOldPass = true.obs;
  var isPasswordVisibleConfirmPass = true.obs;
  var isNewPasswordsMatched = false.obs;
  var passwordSave = false.obs;
  var isAllDataFilled = false.obs;
  var phoneNumberString = "".obs;
  var newphoneNumberString = "".obs;

  final formKeyOldPass = GlobalKey<FormState>();
  final formKeyPhoneNo = GlobalKey<FormState>();
  var visibleIdentity = false.obs;
  var nameVisible = false.obs;

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

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getProfileData();

      if (await PreferenceHelper.instance.getData(Pref.isProfileFaqSeen) ?? true) {
        await PreferenceHelper.instance.setData(Pref.isProfileFaqSeen, false);
        Get.to(() => const ProfileFaqPage());
      }
    });
  }
  Future<bool> updatePassword(BuildContext context, TextEditingController ?oldPasswordController, TextEditingController ? newPasswordController) async {
    try {
      showLoading();
      await UserRepo.getInstance().updateProfile(
        data: {
          "newPassword": newPasswordController?.text,
          "oldPassword": oldPasswordController?.text
        },
      ).then((response) {
        response.fold((l) async {
          errorSnack(l.errorMessage.toString());

          hideLoading();
          String successText = "Your profile is not Updated";
          errorSnack(successText);

          return false;

        },
                (r) async {

              // updateProfileModel.value=r;
              // PreferenceHelper.instance.setData(Pref.token, r.data?.accesstoken);
              hideLoading();
              String successText = "Your Password update Confirmation Sent on your Email, Please confirm it.";
              successSnack(successText);
              // await Dialogs.generalDialog(context,
              //     successText
              // );
              print(updateProfileModel.value);
              return true;
            }
        );
      });
    } catch (e) {
      errorSnack("$e");
      return false;
    }
    hideLoading();

    return false;

  }
  Future<bool> updateName(BuildContext context, String name) async {
    try {
      showLoading();
      await UserRepo.getInstance().updateProfile(
        data: {
          "fullname": name,
        },
      ).then((response) {
        response.fold((l) async {
          hideLoading();
          return false;
        },
                (r) async {

              // updateProfileModel.value=r;
              // PreferenceHelper.instance.setData(Pref.token, r.data?.accesstoken);
              await getProfileData();
              hideLoading();

              String successText = "Your Name is Updated Successfully";

              successSnack(successText);
              print(updateProfileModel.value);
              return true;
            }
        );
      });
    } catch (e) {
      print(e);

      DialogService.proceedDialogWithIcon(
          Icons.warning_amber,
          "Warning",
          "Request",
          "You can't change your name directly from now on. You can request with necessary documents.",
          AppColors.appSecondaryBackgroundColor,
              () {
            var data = UpdateData(
              fullNameController.text,
              emailController.text,
            );
            Get.to(() => const ProfileUpdatePage(), arguments: data);
          });
      return false;
    }
    hideLoading();

    return false;
  }

  Future<bool> updatePhoneno(BuildContext context, String phone) async {
    try {
      showLoading();
      await UserRepo.getInstance().updateProfile(
        data: {
          "phoneNumber": phone,
        },
      ).then((response) {
        response.fold((l) async {
          errorSnack(l.errorMessage.toString());

          hideLoading();
          String successText = "Your profile is not Updated";
          errorSnack(successText);

          return false;

        },
                (r) async {

              // updateProfileModel.value=r;
              // PreferenceHelper.instance.setData(Pref.token, r.data?.accesstoken);
              await getProfileData();
              hideLoading();

              String successText = "Your Phone no is Updated Successfully";

              successSnack(successText);
              print(updateProfileModel.value);
              return true;
            }
        );
      });
    } catch (e) {
      errorSnack("$e");
      return false;
    }
    hideLoading();

    return false;
  }


  Future<void> getProfileData() async {
    try {
      showLoading();
      await UserRepo.getInstance().GetProfileModelData(
      ).then((response) {
        response.fold((l) {
          errorSnack(l.errorMessage.toString());
          hideLoading();
        }, (r) async {
          profileModel.value=r;
          fullNameController.text=profileModel.value?.result?.fullname??"";
          phoneNumberString.value=profileModel.value?.result?.phoneNumber??"";
          emailController.text=profileModel.value?.result?.email??"";
          userId.value =profileModel.value?.result?.userid??"";
          refCode.value=profileModel.value?.result?.referralCode??"";
          passwordController.text=password.value;
          fullName.value=profileModel.value?.result?.fullname??"";
          final frPhone0 = PhoneNumber.parse(profileModel.value?.result?.phoneNumber??"");
          print("Sakib checking countrycode: $frPhone0");
          countryCode.value=frPhone0.isoCode.name;
          print(frPhone0.isoCode.name);
          print(frPhone0.countryCode);
          print(r);
          print(profileModel.value);
          hideLoading();

        });
      });
    } catch (e) {
      errorSnack("$e");
      hideLoading();

    }
    finally {
      // Hide loading indicator in the 'finally' block to ensure it's hidden even if an exception occurs
      hideLoading();
    }
    hideLoading();

  }

}