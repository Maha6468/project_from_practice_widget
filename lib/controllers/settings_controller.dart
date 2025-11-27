import 'dart:convert';
import 'dart:ui';

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_from_practice_widget/controllers/profile_controller.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/app_loading.dart';
import '../common/global_widget.dart';
import '../common/perfrance.dart';
import '../common/string.dart';
import '../data/repo/repo.dart';
import '../models/logout_responce_model.dart';
import '../models/profile_model.dart';
import '../routes/app_pages.dart';
import '../views/widgets/dialogs.dart';

class SettingsController extends GetxController {
  var userId = "".obs;
  var referCode = "".obs;
  var language = "English".obs;
  var languageName = "English".obs;
  var languageCode = "en".obs;
  var fullName = "".obs;
  var canNotify = true.obs;
  final languageCache = GetStorage();
  var profileModel = Rx<ProfileModel?>(null);
  var isNetworkWidgetOn = true.obs;
  late SharedPreferences prefs;
  void getProfileData() async {
    try {
      showLoading();
      await UserRepo.getInstance().GetProfileModelData().then((response) {
        response.fold((l) {
          errorSnack(l.errorMessage.toString());
          hideLoading();
        }, (r) async {
          fullName.value = profileModel.value?.result?.fullname ?? "";
          profileModel.value = r;
          fullName.value = profileModel.value?.result?.fullname ?? "";
          userId.value = profileModel.value?.result?.userid ?? "";
          referCode.value = profileModel.value?.result?.referralCode ?? "";
          canNotify.value = profileModel.value?.result?.canNotify ?? false;
          print(profileModel.value);
          hideLoading();
        });
      });
    } catch (e) {
      errorSnack("$e");
      hideLoading();
    } finally {
      // Hide loading indicator in the 'finally' block to ensure it's hidden even if an exception occurs
      hideLoading();
    }
    hideLoading();
  }

  Future<void> updateWidgetSettings({required bool update}) async {
    await prefs.setBool(AppString.cancelWrapper, !update);
    isNetworkWidgetOn.value = !update;
    if(!update)
    {
      DialogsAction action = await Dialogs.generalDialog(Get.context!, "Offline Widget will show if no internet.");
    }
    else
    {
      DialogsAction action = await Dialogs.restartAppDialog(Get.context!, "Offline Widget will not show even without internet & you need to restart the app to apply changes.");
      if(action == DialogsAction.yes){
        await Restart.restartApp();
      }
    }
  }

  void updateNotification({bool update=false,  var context}) async {
    try {
      showLoading();
      await UserRepo.getInstance().updateNotification(update).then((response) {
        response.fold((l) {
          errorSnack(l.errorMessage.toString());
          hideLoading();
        }, (r) async {

          if(update)
          {
            final action = await Dialogs.generalDialog(context, "Notification is turned on. You will receive all automatic updates from orbaic.");

          }
          else
          {
            final action = await Dialogs.generalDialog(context, "Notification is turned off. You will not receive any automatic updates from orbaic");
          }

          // fullName.value = profileModel.value?.result?.fullname ?? "";
          // profileModel.value = r;
          // fullName.value = profileModel.value?.result?.fullname ?? "";
          // userId.value = profileModel.value?.result?.userid ?? "";
          // referCode.value = profileModel.value?.result?.referralCode ?? "";
          // canNotify.value = profileModel.value?.result?.canNotify ?? false;
          // print(profileModel.value);
          // hideLoading();
        });
      });
    } catch (e) {
      errorSnack("$e");
      hideLoading();
    } finally {
      // Hide loading indicator in the 'finally' block to ensure it's hidden even if an exception occurs
      hideLoading();
    }
    hideLoading();
  }

  var logoutModel = Rx<LogoutResponceModel?>(null);
  final ProfileController proController = Get.put(ProfileController());

  void logout() async {
    try {
      showLoading();
      await UserRepo.getInstance().logout().then((response) {
        response.fold((l) {
          errorSnack(l.errorMessage.toString());
          hideLoading();
        }, (r) async {
          if (r.result != null) {
            logoutModel.value = r;
            successSnack(r.result.toString());
            final SharedPreferences prefs =
            await SharedPreferences.getInstance();
            prefs.remove(Pref.token);
            Get.offAllNamed(Routes.LOGIN);
            print(r);
            hideLoading();
          }
        });
      });
    } catch (e) {
      errorSnack("$e");
      hideLoading();
    } finally {
      // Hide loading indicator in the 'finally' block to ensure it's hidden even if an exception occurs
      hideLoading();
    }
    hideLoading();
  }

  void deleteAccount() async {
    var requestData = {"reason": "something", "description": "full data"};
    try {
      showLoading();
      final response = await UserRepo.getInstance().deleteAccount(
        data: json.encode(requestData),
      );

      response.fold(
            (error) {
          errorSnack(error.errorMessage.toString());
          hideLoading();
        },
            (result) {
          successSnack(result.result.toString());
          hideLoading();
          logout();

        },
      );
    } catch (e) {
      errorSnack("$e");
      hideLoading();
    } finally {
      hideLoading();
    }
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(AppString.cancelWrapper)){
      isNetworkWidgetOn.value = (prefs.getBool(AppString.cancelWrapper))!;
    } else {
      isNetworkWidgetOn.value = true;
    }
    getProfileData();
    userId.value = proController.userId.value ?? "";
    referCode.value = proController.refCode.value ?? "";
    fullName.value = proController.fullName.value ?? "";
  }


  Future<void> changeLanguage(String languageName) async {
    String param1 = 'en', param2 = 'US';
    switch (languageName) {
      case 'English':
        param1 = 'en';
        param2 = 'US';
        break;
      case 'Bangla':
        param1 = 'bn';
        param2 = 'BD';
        break;

      case 'Hindi':
        param1 = 'hi';
        param2 = 'IN';
        break;

      case 'French':
        param1 = 'fr';
        param2 = 'FR';
        break;
      case 'Chinese':
        param1 = 'zh';
        param2 = 'CN';
        break;
      case 'Nigerian':
        param1 = 'yo';
        param2 = 'NG';
        break;
      case 'Urdu':
        param1 = 'ur';
        param2 = 'PK';
        break;

      case 'Vietnamese':
        param1 = 'vi';
        param2 = 'VN';
        break;

      case 'Filipino':
        param1 = 'fil';
        param2 = 'PH';
        break;

      case 'Indonesian':
        param1 = 'id';
        param2 = 'ID';
        break;

      case 'Spanish':
        param1 = 'es';
        param2 = 'ES';
        break;

      case 'German':
        param1 = 'de';
        param2 = 'DE';
        break;

      case 'Arabic':
        param1 = 'ar';
        param2 = 'SA';
        break;

      default:
        param1 = 'en';
        param2 = 'US';
    }
    var locale = Locale(param1, param2);
    await languageCache.write(AppString.languageSelected, "$param1,$param2");
    Get.updateLocale(locale);
  }

}


