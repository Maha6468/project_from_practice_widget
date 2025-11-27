import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../common/app_loading.dart';
import '../common/global_widget.dart';
import '../data/repo/repo.dart';
import '../models/stack_history_model.dart';
import '../models/wallet_token_model.dart';

class StackingController extends GetxController{
  var lookUpRate = 100.0.obs;
  var totalAciTokensMiningAndQuiz = 0.0.obs;
  var totalAciTokensReferralAndBoost = 0.0.obs;
  var duration = 4.obs;
  var isLookUpFromMain = true.obs;
  TextEditingController durationController = TextEditingController();
  var walletTokenModel = Rx<WalletTokenModel?>(null);


  Future<void> doStacking() async {
    print("lookup: ${lookUpRate.value.floor()}");
    print("Duration: ${duration.value}");

    showLoading();
    final response = await UserRepo.getInstance().doStacking(
      data: {
        "lookupRate": lookUpRate.value.floor(),
        "durationInYears": duration.value,
        "mainToken": isLookUpFromMain.value
      },
    );
    try{
      response.fold((error) {
        print("Stacking123 Error11: ${error.toString()}");
        try {
          // Remove leading and trailing whitespace and curly braces
          error = error.trim().substring(1, error.length - 1);

          // Split the string into key-value pairs
          List<String> keyValuePairs = error.split(',');

          // Create a Map to hold key-value pairs
          Map<String, String> errorMap = {};
          for (String pair in keyValuePairs) {
            List<String> parts = pair.split(':');
            if (parts.length == 2) {
              // Remove leading and trailing whitespace and quotes
              String key = parts[0].trim().replaceAll("'", "");
              String value = parts[1].trim().replaceAll("'", "");
              errorMap[key] = value;
            }
          }

          // Extract the error message
          String errorMessage = errorMap["ErrorMessage"] ?? "Unknown error";

          // Show the error message
          errorSnack(errorMessage);
        } catch (e) {
          // If extraction fails, show the original error string
          errorSnack(error.toString());
        }
        hideLoading();
      }, (r) {
        hideLoading();
        successSnack(r['result']);
      });
    } catch(e){
      errorSnack("$e");
      print("Stacking123: error: $e");
      hideLoading();
    }

    await loadTokens();

  }


  Future<void> loadTokens() async {
    try {
      showLoading();
      await UserRepo.getInstance().getWallet().then((response) {
        response.fold((l) {
          errorSnack(l.errorMessage.toString());
          hideLoading();
        }, (r) async {
          walletTokenModel.value = r;
          totalAciTokensMiningAndQuiz.value = r.result!.totalMineAndQuize!;
          totalAciTokensReferralAndBoost.value = r.result!.totalRefAndBoost!;
          print("Wallet Skb: $r");
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



  Future<List<StackHistoryModel>> stackHistory() async {
    List<StackHistoryModel> models = [];
    try {
      showLoading();
      await UserRepo.getInstance().stackHistory().then((response) {
        response.fold((l) {
          print("Sakib Implemented refresh dashboard: error $l");
          errorSnack(l.errorMessage.toString());
          hideLoading();
        }, (r) async {
          models = r;
          models.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
          return models;
        });
      });
    } catch (e) {
      errorSnack("$e");
      hideLoading();
    } finally {
      hideLoading();
    }
    return models;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadTokens();
  }
}