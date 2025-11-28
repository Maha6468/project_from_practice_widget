import 'package:get/get.dart';

import '../common/app_loading.dart';
import '../common/global_widget.dart';
import '../common/perfrance.dart';
import '../data/repo/repo.dart';
import '../enums.dart';
import '../models/logout_responce_model.dart';
import '../models/profile_model.dart';

class MainPageController extends GetxController{
  var selectedBottomBarItem = PageName.home.obs;
  var logoutModel = Rx<LogoutResponceModel?>(null);
  var fullName="".obs;
  var email="".obs;
  var profileModel = Rx<ProfileModel?>(null);
  var isMiningEnabled = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await getProfileData();
    await getMiningStatus();
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

          fullName.value=profileModel.value?.result?.fullname??"";
          email.value=profileModel.value?.result?.email??"";

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



  //***************************** logout   Api call ************************************/
  Future<bool> logout() async {
    bool status = false;
    try {
      showLoading();
      await UserRepo.getInstance().logout(
      ).then((response) {
        response.fold((l) {
          errorSnack(l.errorMessage.toString());
          hideLoading();
          status = false;
        }, (r) async {

          if (r.result != null) {
            logoutModel.value=r;
            successSnack(r.result.toString());

            print(r);
            hideLoading();
            status = true;
          }

        });
      });
    } catch (e) {
      errorSnack("$e");
      hideLoading();
      status = false;

    }
    finally {
      // Hide loading indicator in the 'finally' block to ensure it's hidden even if an exception occurs
      hideLoading();
    }
    hideLoading();

    return status;
  }

  Future<void> getMiningStatus() async {
    try {
      bool? visibility = await PreferenceHelper.instance.getData(Pref.miningEnabledStatus);
      isMiningEnabled.value = visibility ?? true;
    } catch (e) {
      isMiningEnabled.value = true;
      print("Error loading preference: $e");
    }
  }
}


//maha
extension on Function() {
  Future<bool?> getData(String miningEnabledStatus) async {}
}