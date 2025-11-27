import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../common/app_loading.dart';
import '../common/global_widget.dart';
import '../data/repo/repo.dart';
import '../models/team_model.dart';
import '../models/wallet_model.dart';

class SupportPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt characterCount = 0.obs;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  // Method to update the character count
  void updateCharacterCount(int count) {
    characterCount.value = count;
  }

  var teamModel = Rx<TeamModel?>(null);
  double totalRefEarn = 0.0;

  //***************************** deshbord   Api call ************************************/
  Future<bool> sendSupportRequest({
    String? subject,
    String? description,
  }) async {
    try {
      showLoading();
      await UserRepo.getInstance().sendSupportRequest(
        data: {
          "subject": subject,
          "message": description,
        },
      ).then((response) {
        response.fold((l) {
          errorSnack(l.errorMessage.toString());

          hideLoading();
          return false;
        }, (r) async {


          subjectController.text="";
          descriptionController.text="";
          // PreferenceHelper.instance.setData(Pref.token, r.data?.accesstoken);
          print(r.result?.value);
          print(teamModel.value);



          successSnack("${r.result?.key} : ${r.result?.value}");
          return true;
        });
      });
    } catch (e) {
      errorSnack("$e");
      return false;
    }
    hideLoading();
    return false;
  }

  @override
  void onInit() {
    super.onInit();
  }
}