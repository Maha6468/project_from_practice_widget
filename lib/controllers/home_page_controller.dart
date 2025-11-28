import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../common/app_loading.dart';
import '../common/firebase_notification/save_notification_list.dart';
import '../common/global_widget.dart';
import '../common/perfrance.dart';
import '../data/repo/repo.dart';
import '../models/dashboard_refresh_model.dart';
import '../models/deshbord_model.dart';

class HomePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var isExtraRewardProgressComplete = false.obs;
  var isQuizProgressComplete = false.obs;
  var isMiningProgressComplete = false.obs;
  var quizSessionProgress = 0.obs;
  var quizSession = 1.obs;
  var activeTeam = 0.obs;
  var totalTeam = 0.obs;
  var deshbordModel = Rx<DeshbordModel?>(null);
  List<String>? teamMembers = [];
  var countdown = '00:00:00'.obs;
  var quizcountdown = '00:00:00'.obs;
  var miningHours = 0.obs;
  var summaryHours = 1.obs;
  static const double tenMillion = 10000000.0;

  var isMinings = true.obs;
  var isMiningEnabled = true.obs;
  var totalBalance = 0.0.obs;
  var quizCountdown = 0.obs;
  var timeLeft = 0.obs;
  var isOffer = false.obs;
  var isAdLoaded = false.obs;
  var dashboardRefreshModel = Rx<DashboardRefreshModel?>(null);

  Timer? timer;
  Timer? timer1;

  Future<void> RegisterFCM() async {
    try {
      showLoading();
      var fcmToken = await PreferenceHelper.instance.getData(Pref.fcmToken) ??
          "";

      final response = await UserRepo.getInstance().RegisterFCM(
          fcmToken: fcmToken);

      response.fold(
            (l) {
          try {
            errorSnack(l.errorMessage.toString());

            hideLoading();
          } catch (e) {
            // If extraction fails, show the original error string
            errorSnack(l.toString());
          }
          hideLoading();
        },
            (r) async {
          print(r);
          if (r.result != null) {
            print(r.result);
          }
        },
      );
    } catch (e) {
      print('Login Exception: $e');
      errorSnack("$e");
      hideLoading();
    }
  }


  Future<void> startMining() async {
    if (isMinings.isTrue) {
      successSnack(
          "Currently, you are running your mining session, and you have ${deshbordModel
              .value?.result?.team?.teamMembers?.activeTeam ?? 0} active referral minings. ");
    }
    else {
      try {
        showLoading();
        await UserRepo.getInstance().startMining().then((response) {
          response.fold((l) {
            isMinings.value = false;
            errorSnack(l.errorMessage.toString());
            hideLoading();
          }, (r) async {
            isMinings.value = true;
            print(r);
            successSnack(
                " you'll initiate a 24-hour mining session. If you log out or uninstall the app, your current mining session will expire");
            await refreshDashboard();
            await getDeshBoardData();
            hideLoading();
          });
        });
      } catch (e) {
        errorSnack("$e");
        hideLoading();
      } finally {
        hideLoading();
      }
    }
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);
    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');
    return '$formattedHours:$formattedMinutes:$formattedSeconds';
  }


  Future<void> getDeshBoardData() async {
    print("==========Deshboard Api called=============");
    try {
      showLoading();
      await UserRepo.getInstance().GetDeshbordData().then((response) {
        response.fold((l) {
          errorSnack(l.errorMessage.toString());
          hideLoading();
        }, (r) async {
          deshbordModel.value = r;
          print('Sakib Checking dashboard: ${deshbordModel.value?.toJson()}');
          if (deshbordModel.value?.result != null &&
              deshbordModel.value?.result?.mine != null) {
            isOffer.value = deshbordModel.value?.result?.isOffer ?? false;
            timeLeft.value =
                int.parse('${deshbordModel.value!.result!.mine!.timeLeft}');
            quizCountdown.value =
                int.parse('${deshbordModel.value?.result?.quiz?.nextQuizTime}');
            startCountdown_for_timeleft(Duration(milliseconds: timeLeft.value));
            startCountdown_for_next_quiz_time(
                Duration(milliseconds: quizCountdown.value));
          }
          isMinings(deshbordModel.value?.result?.mine?.isMining ?? false);
          totalBalance.value =
              (deshbordModel.value!.result!.balance! * tenMillion) +
                  (dashboardRefreshModel.value!.result!.newMinedTokens! *
                      tenMillion);
          totalBalance.value.toPrecision(10);
          if (deshbordModel.value?.result != null &&
              deshbordModel.value?.result?.team != null &&
              deshbordModel.value?.result?.team?.teamMembers != null) {
            List<TeamMember> members =
                deshbordModel.value?.result?.team?.teamMembers?.teamMembers ?? [];
            miningHours.value = deshbordModel.value?.result?.mine?.mineSummary?.miningHours ?? 0 % 720;
            summaryHours.value = deshbordModel.value?.result?.mine?.mineSummary?.summaryHours ?? 720;
            quizSessionProgress.value = deshbordModel.value?.result?.quiz?.quizSummary?.quizSeasonProgress ?? 1;
            quizSession.value = deshbordModel.value?.result?.quiz?.quizSummary?.quizSeason ?? 300;

            teamMembers = members.map((member) => member.fullName!).toList();
          }

          print(r);
          hideLoading();
        });
      });
    } catch (e) {
      errorSnack("$e");
      hideLoading();
    } finally {
      hideLoading();
    }
  }


  Future<void> refreshDashboard() async {
    print("==========Refresh Deshboard Api called=============");
    try {
      showLoading();
      await UserRepo.getInstance().refreshDashboard().then((response) {
        response.fold((l) {
          print("Sakib Implemented refresh dashboard: error $l");
          errorSnack(l.errorMessage.toString());

          hideLoading();
        }, (r) async {
          dashboardRefreshModel.value = r;
          activeTeam.value = dashboardRefreshModel.value?.result?.activeTeam?.active ?? 0;
          totalTeam.value =  dashboardRefreshModel.value?.result?.activeTeam?.total ?? 0;
          print("Sakib Implemented refresh dashboard: ${r.result!.newHashRate!}");
        });
      });
    } catch (e) {
      errorSnack("$e");
      hideLoading();
    } finally {
      hideLoading();
    }
  }

  void startCountdown_for_timeleft(Duration duration) {
    countdown.value = formatDuration(duration);

    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      duration -= const Duration(seconds: 1);
      timeLeftTask(duration);
    });
  }

  void timeLeftTask(Duration duration) async {
    if(duration.inSeconds == 0){
      await refreshDashboard();
      await getDeshBoardData();
    }
    //for the timeleft
    if (duration.isNegative) {
      isMinings.value = false;
      countdown.value = '00:00:00';
      // Handle timer completion if needed
    } else {
      isMinings.value = true;
      // totalBalance.value=totalBalance.value+(deshbordModel.value?.result?.currentHashRate??0.0/3600);
      double currentValue = dashboardRefreshModel.value?.result?.newHashRate ?? 0.0;
      //  currentValue = currentValue.toPrecision(10);
      double totalBalanceValue = totalBalance.value + (currentValue * tenMillion / 3600.00);
      //  totalBalanceValue = totalBalanceValue.toPrecision(10);
      // String formattedValue = totalBalanceValue.toStringAsPrecision(5); // 8 to include 6 digits after the decimal point and additional digits for rounding
      totalBalance.value = totalBalanceValue; // Assigning the parsed double value
      print("balance 1======> ${totalBalance.value}");

      countdown.value = formatDuration(duration);
    }// Handle the task result
  }


  void startCountdown_for_next_quiz_time(Duration nextQuizDuration) {
    quizcountdown.value = formatDuration(nextQuizDuration);

    if (timer1 != null && timer1!.isActive) {
      timer1!.cancel();
    }

    timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
      nextQuizDuration -= const Duration(seconds: 1);
      quizTimeTask(nextQuizDuration);
    });
  }

  void quizTimeTask(Duration nextQuizDuration) async {
    nextQuizDuration -= const Duration(seconds: 1);
    if (nextQuizDuration.inSeconds == 0) {
      await refreshDashboard();
      await getDeshBoardData();
    }
    if (nextQuizDuration.isNegative) {
      isMiningProgressComplete(true);
      quizcountdown.value = '00:00:00';
    } else {
      isMiningProgressComplete(false);
      quizcountdown.value = formatDuration(nextQuizDuration);
    }
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
    }
    if (timer1 != null) {
      timer1!.cancel();
    }
    super.onClose();
  }

  @override
  Future<void> didChangeDependencies(BuildContext context) async {
    super.didChangeDependencies(context);
    await refreshDashboard();
    await getDeshBoardData();
    startCountdown_for_timeleft(Duration(milliseconds: timeLeft.value));
    startCountdown_for_next_quiz_time(
        Duration(milliseconds: quizCountdown.value));
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await RegisterFCM();
    await refreshDashboard();
    await getDeshBoardData();
    await getMiningStatus();
  }

  Future<void> getMiningStatus() async {
    try {
      bool? visibility = await PreferenceHelper.instance.getData(Pref.miningEnabledStatus);
      isMiningEnabled.value = visibility ?? false;
      print("Error_loading_preference not: visibility: $visibility");
    } catch (e) {
      isMiningEnabled.value = false;
      print("Error_loading_preference: $e");
    }
  }

}


//maha
extension on Function() {
  Future<bool?> getData(String miningEnabledStatus) async {}
}