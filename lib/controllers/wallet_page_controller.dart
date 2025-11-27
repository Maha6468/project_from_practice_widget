import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_from_practice_widget/controllers/stacking_controller.dart';

import '../common/app_loading.dart';
import '../common/firebase_notification/save_notification_list.dart';
import '../common/global_widget.dart';
import '../data/repo/repo.dart';
import '../models/transferCoinModel.dart';
import '../models/wallet_model.dart';
import 'package:rxdart/rxdart.dart' as dart;

import '../models/wallet_token_model.dart';
import '../models/withDrawShaib.dart';
import '../models/withdraw_setup_model.dart';
import '../views/stacking_views/stacking_page.dart';

class WalletPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var walletNetworks = <String>[].obs;
  var addressOrBenificial = <String>[].obs;
  var hintText = "Please Enter Wallet Address".obs;
  var selectedKey = "walletAddress".obs;
  StackingController stackingController = Get.put(StackingController());
  var walletTokenModel = Rx<WalletTokenModel?>(null);
  var miningToken = 0.0.obs;
  var stackingToken = 0.0.obs;
  var boostToken = 0.0.obs;
  var referenceToken = 0.0.obs;
  var quizToken = 0.0.obs;
  var totalToken = 0.0.obs;
  var extraReward = 0.0.obs;
  var marchenToken = 0.0.obs;
  var isMerchant = false.obs;
  var withdrawSetup = Rx<WithdrawSetupModel?>(null);


  void fetchWalletNetworks() {
    walletNetworks.assignAll(['Network(BSC20)', 'BinanceId']);
    // Set the initial value of selectedNetwork to the first item in walletNetworks
    selectedNetwork.value = walletNetworks.isNotEmpty ? walletNetworks[0] : '';
  }

  void fetchwalletAddressOrBinanceID() {
    addressOrBenificial.assignAll(['Network(BSC20)', 'BinanceId']);
    // Set the initial value of selectedNetwork to the first item in walletNetworks
    SelectedwalletAddressOrBinanceID.value = addressOrBenificial.isNotEmpty ? addressOrBenificial[0] : '';
  }

  var selectedNetwork = RxString('');
  var SelectedwalletAddressOrBinanceID = RxString('');
  var walletModel = Rx<WalletResponseModel?>(null);
  var withdrawshib = Rx<WithDrawShib?>(null);
  var trasferrCoin = Rx<TransferCoinModel?>(null);
  final userIdFormKey = GlobalKey<FormState>();
  final walletAddressOrBinanceIDFormKey = GlobalKey<FormState>();
  final walletNetworkFormKey = GlobalKey<FormState>();
  final binanceIdFormKey = GlobalKey<FormState>();
  final AmountFormKey = GlobalKey<FormState>();
  TextEditingController userIdController = TextEditingController();
  TextEditingController AmountController = TextEditingController();
  TextEditingController AmountControllertrasfer = TextEditingController();
  TextEditingController walletAddressOrbinanceIdController =
  TextEditingController();
  var widgetVisibility = false.obs;
  //***************************** withdraw shib   Api call ************************************/

  Future<void> withdrawShib(BuildContext context) async {
    try {
      showLoading();
      final response = await UserRepo.getInstance().withdrawShib(data: {
        selectedKey.value: walletAddressOrbinanceIdController.text.toString(),
        "walletNetwork": SelectedwalletAddressOrBinanceID.value,
        "amount": AmountController.text
      });

      response.fold(
            (l) {
          errorSnack(l.errorMessage.toString());
          hideLoading();
        },
            (r) async {

          walletAddressOrbinanceIdController.text = "";
          AmountController.text = "";
          // Navigator.of(context).pop();
          successSnack("You Withdraw Shib Successfully.\nYour withdrawal will be credited within 48 hours");
          print(r);
          withdrawshib.value = r;
          print(r);
          hideLoading();
          getData();
          fetchWalletNetworks(); // Call fetchWalletNetworks on initialization

        },
      );
    } catch (e) {
      print(' Exception: $e');
      errorSnack("$e");
      hideLoading();
    }
  }

  Future<void> transferCoin(BuildContext context) async {
    try {
      showLoading();
      final response = await UserRepo.getInstance().transferCoin(data: {
        "userId": userIdController.text,
        "amount": AmountControllertrasfer.text
      });

      response.fold(
            (l) {
          errorSnack(l.errorMessage.toString());
          hideLoading();
        },
            (r) async {
          userIdController.text = "";
          AmountControllertrasfer.text = "";
          getData();

          // Navigator.of(context).pop();
          successSnack("You Transferred Coin  Successfully");
          print(r);
          trasferrCoin.value = r;
          print(r);
          hideLoading();
        },
      );
    } catch (e) {
      print(' Exception: $e');
      errorSnack("$e");
      hideLoading();
    }
  }

  //***************************** deshbord   Api call ************************************/
  Future<void> getData() async {
    try {
      showLoading();
      await UserRepo.getInstance().GetWalletModelData().then((response) {
        response.fold((l) {
          errorSnack(l.errorMessage.toString());
          hideLoading();
        }, (r) async {
          walletModel.value = r;
          print("Wallet Skb: $r");
          hideLoading();
          widgetVisibility.value = true;
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

  Future<void> loadTokens() async {
    try {
      showLoading();
      await UserRepo.getInstance().getWallet().then((response) {
        response.fold((l) {
          errorSnack(l.errorMessage.toString());
          hideLoading();
        }, (r) async {
          walletTokenModel.value = r;
          stackingToken.value = r.result!.stackedTokens!;
          referenceToken.value = r.result!.referralTokens!;
          boostToken.value = r.result!.referralMineBonusTokens!;
          miningToken.value = r.result!.minedTokens!;
          quizToken.value = r.result!.quizRewardTokens!;
          totalToken.value = r.result!.totalAciTokens!;
          isMerchant.value = walletTokenModel.value!.result!.isMerchant!;

          if (isMerchant.value) {
            marchenToken.value = walletTokenModel.value?.result?.merchantToken ?? 0.0;
          }
          extraReward.value = walletTokenModel.value?.result?.extraReward ?? 0.0;
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

  Future<void> getWithDrawSetup() async {
    showLoading();
    try {
      String url = 'https://app.orbaic.com/api/shib-withdraw-setup';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data != null && data['result'] != null) {
          final result = data['result'];
          print(result);
          withdrawSetup.value = WithdrawSetupModel.fromJson(result);
        } else {
          print("withdraw setup=========> result null");
        }
        hideLoading();
      } else {
        print("withdraw setup=========> something went wrong!");
        hideLoading();
      }
    } catch (e) {
      print("withdraw setup=========> $e");
      hideLoading();
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getData();
    await loadTokens();
    await getWithDrawSetup();
    fetchWalletNetworks(); // Call fetchWalletNetworks on initialization
    fetchwalletAddressOrBinanceID();
  }

  Future<void> goToStacking()async{
    Get.to(() => StackingPage());
  }

  List<PieChartSectionData> pieChartSections(){
    List<Color> colors = [
      Colors.red, Colors.green, Colors.blue, Colors.amber, Colors.cyanAccent, Colors.purple, Colors.brown
    ];
    if (!isMerchant.value) {
      colors.removeAt(6);
    }
    return List.generate(colors.length, (i){
      double value = 0;
      switch(i){
        case 0: value = miningToken.value;
        break;
        case 1: value = quizToken.value;
        break;
        case 2: value = boostToken.value;
        break;
        case 3: value = referenceToken.value;
        break;
        case 4: value = stackingToken.value;
        break;
        case 5: value = extraReward.value;
        break;
        case 6: value = marchenToken.value;
      }
      double radius = 35.0;
      return PieChartSectionData(
          color: colors[i],
          value: value.toPrecision(1),
          // title: '$value%',
          //  titleStyle: TextStyle(
          //      fontSize: 16
          //  ),
          radius: radius);
    });
  }
}