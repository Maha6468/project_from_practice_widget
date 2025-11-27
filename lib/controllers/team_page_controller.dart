
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../common/app_loading.dart';
import '../common/global_widget.dart';
import '../data/repo/repo.dart';
import '../models/join_referal_model.dart';
import '../models/team_model.dart';
import '../views/widgets/dialogs.dart';
class TeamPageController extends GetxController with GetSingleTickerProviderStateMixin {

  TextEditingController refController = TextEditingController();
  var teamModel = Rx<TeamModel?>(null);
  var joinReferalModel = Rx<JoinReferalModel?>(null);
  double totalRefEarn=0.0;
  // var isReferredBy = false.obs;
  //***************************** deshbord   Api call ************************************/
  void getData() async {
    try {
      showLoading();
      await UserRepo.getInstance().GetTeamModelData(
      ).then((response) {
        response.fold((l) {
          errorSnack(l.errorMessage.toString());
          hideLoading();
        }, (r) async {
          teamModel.value=r;
          print(teamModel.value);
          hideLoading();
          var totalReferralEarned = teamModel.value?.result?.totalReferralEarned ?? 0.0;
          var totalReferralMiningBonusEarned = teamModel.value?.result?.totalReferralMiningBonusEarned ?? 0.0;
          totalRefEarn = (totalReferralMiningBonusEarned + totalReferralEarned).toDouble();
          List<TeamMemberElement>? teamMembers = teamModel.value?.result?.teamMember?.team?.teamMembers;
          print(teamMembers);
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


  void joinReferral(String refCode, BuildContext context) async {

    if(refCode=="")
    {
      errorSnack("Please Enter the Referral code ");
    }
    else
    {
      try {
        showLoading();
        await UserRepo.getInstance().joinReferral(refCode
        ).then((response) {
          response.fold((l) {
            errorSnack(l.errorMessage.toString());
            hideLoading();
          }, (r) async {
            joinReferalModel.value = r;
            print(joinReferalModel.value);
            hideLoading();
            getData();
            final action = await Dialogs.generalDialog(context,
                "Congratulations! You've earned 2 ACI tokens through your referral. Kindly check your balance to confirm the updated amount.");
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

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}