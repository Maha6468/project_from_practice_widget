import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../colors/app_colors.dart';
import '../common/app_loading.dart';
import '../common/global_widget.dart';
import '../data/repo/repo.dart';
import '../models/RewardsWithdrawModel.dart';
import '../models/team_model.dart';
import '../utility/widget_to_image.dart';


class RewardHistoryController extends GetxController {
  var historyModel = Rx<Rewardswithdrawmodel?>(null);
  var teamModel = Rx<TeamModel?>(null);
  var selectedHistory = Rx<History?>(null);

  @override
  void onInit() async {
    await getRewardHistory();
    await getTeamData();
    super.onInit();
  }

  Future<void> getRewardHistory() async {
    try {
      showLoading();
      await UserRepo.getInstance().getWithdrawHistory().then((response) {
        response.fold((l) {
          print("Sakib Implemented refresh dashboard: error $l");
          errorSnack(l.errorMessage.toString());
          hideLoading();
        }, (r) async {
          print("response===> $r");
          historyModel.value = r;
        });
      });
    } catch (e) {
      print("reward-history-error===============> $e");
      errorSnack("$e");
      hideLoading();
    } finally {
      hideLoading();
    }
  }

  Future<void> getTeamData() async {
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
        });
      });
    } catch (e) {
      print("team-data-error===============> $e");
      errorSnack("$e");
      hideLoading();

    }
    finally {
      // Hide loading indicator in the 'finally' block to ensure it's hidden even if an exception occurs
      hideLoading();
    }
    hideLoading();

  }

  void createAndShareImage(History? history) async {
    showLoading();
    WidgetToImage.createImageFromWidget(
      shareComponent(history),
      wait: const Duration(seconds: 1),
      imageSize: const Size(512, 512),
      logicalSize: const Size(512, 512),
    ).then((Uint8List? imageBytes) async {
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/${history?.id}.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(imageBytes!);
      hideLoading();

      // Share the image
      await Share.shareXFiles([XFile(imagePath)]);
    });
  }

  Widget shareComponent(History? history) {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.appBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("${history?.finalAmount} SHIB", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
          Text("SHIBA INU WITHDRAWAL FROM ORBAIC MINER APP", style: TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.center,),
          SizedBox(height: 20),
          Text('My Invitation Code', style: TextStyle(fontSize: 20, color: Color(0xffc0c0c0)),),
          Divider(color: Color(0x1aFFFFff), thickness: 2,),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Color(0x1aFFFFff),
            ),
            child: Text(
              '${teamModel.value?.result?.referralCode}',
              style: TextStyle(
                color: Color(0x80FFFFff),
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: 160,
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
                "JOIN NOW!",
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
          SizedBox(height: 10),
          Text("USE MY REFERRAL CODE & GET FREE 2 ACI TOKEN!", style: TextStyle(fontSize: 16, color: Colors.white70),textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}