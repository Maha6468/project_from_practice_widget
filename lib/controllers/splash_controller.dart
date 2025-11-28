import 'dart:io';

import 'package:get/get.dart';
import '../common/perfrance.dart';
import '../data/repo/repo.dart';
import '../models/check_app_status_model.dart';
import '../routes/app_pages.dart';
import 'auth_controller.dart';



class SplashController extends GetxController{
  var checkAppStatusModel = Rx<CheckAppStatusResponseModel?>(null);
  var progressBarVisibility = false.obs;
  Future<String> getToken() async {
    var token = await PreferenceHelper.instance.getData(Pref.token) ?? "";
    return token;
  }

  startProgress(String token, bool isForceLogout){
    if(progressBarVisibility.value){
      Future.delayed(const Duration(milliseconds: 3000), () async {
        print(token);
        if (token.isNotEmpty) {
          if(isForceLogout) {
            PreferenceHelper.instance.setData(Pref.token, "");
            Get.offAllNamed(Routes.LOGIN);
          } else {
            Get.offAllNamed(Routes.MAIN);
          }
        } else {
          // Token doesn't exist, navigate to the login page
          bool isMiningEnabled = await PreferenceHelper.instance.getData(Pref.miningEnabledStatus) ?? true;
          if (isMiningEnabled || !Platform.isIOS) {
            Get.offAllNamed(Routes.LOGIN);
          } else {
            Get.put(AuthController()).login(
              email: "masum.abir43@gmail.com",
              password: "Masum.abir43@",
            );
          }

        }
      });
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }

}
  
//maha
extension on Function() {
  Future getData(String token) async {}

  void setData(String token, String s) {}
}