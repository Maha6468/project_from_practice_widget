import 'dart:io';

import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ads/AdManager.dart';
import '../../colors/app_colors.dart';
import '../../common/constants.dart';
import '../../common/firebase_notification/firebase_notification.dart';
import '../../common/global_widget.dart';
import '../../common/perferenceVisibility.dart';
import '../../common/perfrance.dart';
import '../../controllers/home_page_controller.dart';
import '../../controllers/main_page_controller.dart';
import '../../enums.dart';
import '../merchant_views/merchant_offer.dart';
import '../pages/all_team_members_page.dart';
import '../quiz_views/quize_home_page.dart';
import '../widgets/claim_shiba_inu_button.dart';
import 'package:gdpr_dialog/gdpr_dialog.dart';

import '../widgets/dialogs.dart';
import '../widgets/quiz_available.dart';
import '../widgets/shake_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomePageController controller = Get.put(HomePageController());
  final MainPageController mainPageController = Get.find();


  // late InterstitialAd interstitialAd;
  // bool isAdLoaded = false;
  int index = 5;
  String status = "none";

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print(
          "test1122 Initial isMiningEnabled.isTrue: ${controller.isMiningEnabled.isTrue}");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (controller.isMiningEnabled.isTrue && controller.isMinings.isFalse) {
          FeatureDiscovery.discoverFeatures(
            context,
            const <String>{'feature1'},
          );
        }
      });

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // await initAd();
        await controller.getDeshBoardData();
        if (Platform.isAndroid) {
          GdprDialog.instance.resetDecision();
          GdprDialog.instance
              .showDialog(isForTest: false, testDeviceId: '')
              .then((onValue) {
            status = 'dialog result == $onValue';
          });

          GdprDialog.instance
              .getConsentStatus()
              .then((value) => status = 'consent status == $value');
        }

        print("authorizationStatus requestPermissionAgain");
        FirebaseNotification.instance.requestPermissionAgain();
      });

      return RefreshIndicator(
        onRefresh: () async {
          await controller.refreshDashboard();
          // controller.getDeshBoardData();
        },
        child: GestureDetector(
          onTap: () {
            if (controller.isMiningEnabled.isTrue) {
              if (controller.isMinings.isFalse) {
                FeatureDiscovery.discoverFeatures(
                  context,
                  const <String>{'feature1'},
                );
              }
            }
          },
          child: Container(
            color: AppColors.appSecondaryColor,
            child: Obx(() => Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: Get.width,
                            height: 1200,
                            child: Obx(
                                  () => (controller.isMiningEnabled.isTrue)
                                  ? PreferenceVisibility(
                                preferenceKey:
                                Pref.miningEnabledStatus,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    controller.isOffer.value
                                        ? InkWell(
                                      onTap: () async {
                                        if (controller.isMinings
                                            .isFalse) {
                                          FeatureDiscovery
                                              .discoverFeatures(
                                            context,
                                            const <String>{
                                              'feature1'
                                            },
                                          );
                                        } else {
                                          Get.to(() =>
                                              MerchantOffer());
                                        }
                                      },
                                      child: ShakeWidget(
                                        child: Icon(
                                          Icons
                                              .wallet_giftcard_outlined,
                                          color: Colors.amber,
                                          size: 32,
                                        ),
                                      ),
                                    )
                                        : SizedBox.shrink(),
                                    Text(
                                      'balance'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.25,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Obx(
                                          () => Text(
                                        (controller.totalBalance
                                            .value /
                                            HomePageController
                                                .tenMillion)
                                            .toStringAsFixed(5),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 32.53,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.16,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      '${controller.dashboardRefreshModel.value?.result?.newHashRate?.toStringAsPrecision(4) ?? ""}/H ACI',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.25,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.people,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Text(
                                          '${controller.activeTeam.value}/${controller.totalTeam.value}',
                                          style: TextStyle(
                                            color: Color(0xFF212D40),
                                            fontSize: 18.30,
                                            fontFamily: 'Poppins',
                                            fontWeight:
                                            FontWeight.w500,
                                            letterSpacing: 1.16,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              )
                                  : Container(
                                width: Get.width,
                                height: 1200,
                                child: const Column(
                                  children: [
                                    Text('\nWelcome to Orbaic!!\n',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.16,
                                        )),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.0),
                                      child: Text(
                                          'Test your knowledge with a variety of topics and questions designed to challenge and entertain you.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'Poppins',
                                            fontWeight:
                                            FontWeight.w600,
                                            letterSpacing: 1.16,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //ripple effect
                          controller.isMinings.isTrue
                              ? Positioned(
                            left: 0,
                            right: 0,
                            top: 200,
                            child: RippleAnimation(
                              duration: const Duration(seconds: 3),
                              repeat: true,
                              color: AppColors.appRippleEffectColor,
                              minRadius: 70,
                              ripplesCount: 4,
                              size: const Size(70, 70),
                              child: Container(),
                            ),
                          )
                              : const SizedBox.shrink(),

                          Positioned(
                              top: 300,
                              left: -130,
                              right: -130,
                              child: Container(
                                height: Get.height + 800,
                                width: Get.width + 300,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(300),
                                        topRight: Radius.circular(300)),
                                    color: AppColors.appBackgroundColor),
                                child: Container(),
                              )),

                          // if (controller.isOverlayVisible) // Show overlay only when visible

                          Positioned(
                              top: 280,
                              left: Get.width / 2 - 75,
                              child: Container(
                                  height: 100,
                                  width: 150,
                                  //padding: EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    //  color: AppColors.appSecondaryBackgroundColor,
                                    //   borderRadius: BorderRadius.all(Radius.circular(60)),
                                  ),
                                  child: const Image(
                                    image: AssetImage(
                                        'assets/images/mining_logo_layer.png'),
                                    width: 70,
                                  ))),

                          Positioned(
                              top: 220,
                              left: Get.width / 2 - 60,
                              child: InkWell(
                                onTap: () async {
                                  if (controller.isMinings.isTrue &&
                                      controller.isMiningEnabled.isTrue) {
                                    print("from local1");
                                    final confirmed = await _showMiningDisclaimerDialog();
                                    if (confirmed) {
                                      await startMining();
                                    }

                                  } else {
                                    Get.to(() => QuizHomePage());
                                  }
                                },
                                child: Container(
                                    height: 120,
                                    width: 120,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: AppColors
                                          .appSecondaryBackgroundColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(60)),
                                    ),
                                    child: Center(
                                      child: DescribedFeatureOverlay(
                                        onComplete: () async {
                                          // Schedule the dialog logic to run after the overlay is dismissed
                                          Future(() async {
                                            print("from feature discovery");
                                            var isAdEnabled = await PreferenceHelper.instance.getData(Pref.isAdEnabled) ?? false;
                                            print("isAdEnabled112233: $isAdEnabled");
                                            if (isAdEnabled) {
                                              bool isAdReady = await AdManager.instance.isAdReady();
                                              if (isAdReady) {
                                                final confirmed = await _showMiningDisclaimerDialog();
                                                if (confirmed) {
                                                  await AdManager.instance.showAd();
                                                  await startMining();
                                                }
                                              } else {
                                                Dialogs.miningNotStartedDialog(context, "");
                                              }
                                            } else {
                                              final confirmed = await _showMiningDisclaimerDialog();
                                              if (confirmed) {
                                                await startMining();
                                              }
                                            }
                                          });
                                          // Dismiss overlay immediately by returning true
                                          return true;

                                          /*                print("from feature discovery");
                                              var isAdEnabled = await PreferenceHelper.instance.getData(Pref.isAdEnabled) ?? false;
                                              print("isAdEnabled112233: $isAdEnabled");
                                              if (isAdEnabled) {
                                                bool isAdReady = await AdManager.instance.isAdReady();
                                                if (isAdReady) {
                                                  final confirmed = await _showMiningDisclaimerDialog();
                                                  if (confirmed) {
                                                    await AdManager.instance.showAd();
                                                    await startMining();
                                                  }

                                                  return Future.value(true);
                                                } else {
                                                  Dialogs.miningNotStartedDialog(context, "");
                                                  return Future.value(true);
                                                }
                                              } else {
                                                final confirmed = await _showMiningDisclaimerDialog();
                                                if (confirmed) {
                                                  await startMining();
                                                }
                                                return Future.value(true);
                                              }*/
                                        },
                                        title: Text(
                                          'start_mining'.tr,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 30.0,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.16,
                                          ),
                                        ),
                                        description: Text(
                                          'click_here'.tr,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 14.30,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.16,
                                          ),
                                        ),
                                        backgroundColor:
                                        const Color(0xff11726a),
                                        featureId: 'feature1',
                                        tapTarget: const Image(
                                          image: AssetImage(
                                              'assets/images/mining_logo.png'),
                                          width: 70,
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            if (controller
                                                .isMinings.isTrue) {
                                              //await controller.interstitialAd.value.show();
                                              print("from local2");
                                              // Dialogs.miningNotStartedDialog(context, "");
                                              final confirmed = await _showMiningDisclaimerDialog();
                                              if (confirmed) {
                                                await startMining();
                                              }
                                            } else {
                                              bool isAdReady =
                                              await AdManager.instance
                                                  .isAdReady();
                                              if (isAdReady) {
                                                final confirmed = await _showMiningDisclaimerDialog();
                                                if (confirmed) {
                                                  await AdManager.instance
                                                      .showAd();
                                                  await startMining();
                                                }

                                              } else {
                                                Dialogs
                                                    .miningNotStartedDialog(
                                                    context, "");
                                              }
                                            }
                                          },
                                          child: const Image(
                                            image: AssetImage(
                                                'assets/images/mining_logo.png'),
                                            width: 70,
                                          ),
                                        ),
                                      ),
                                    )),
                              )),

                          Positioned(
                              top: 380,
                              left: 0,
                              right: 0,
                              child: Column(
                                children: [
                                  PreferenceVisibility(
                                    preferenceKey: Pref.miningEnabledStatus,
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/spinner_clock_icon.png'),
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                  PreferenceVisibility(
                                    preferenceKey: Pref.miningEnabledStatus,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Color(0xff64D2FF),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Obx(() => Text(
                                          controller.countdown.value,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color(0xFF64D2FF),
                                            fontSize: 18.30,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.16,
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(height: 10,),
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    margin: EdgeInsets.all(12),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xff364156),
                                            Color(0xff212D40)
                                          ]),
                                    ),
                                    child: Obx(
                                          () => Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 28,
                                              ),
                                              Expanded(
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                        'learn_with_us'
                                                            .tr,
                                                        style: TextStyle(
                                                          color:
                                                          Colors.white,
                                                          fontSize: 14.23,
                                                          fontFamily:
                                                          'Poppins',
                                                          fontWeight:
                                                          FontWeight
                                                              .w400,
                                                          letterSpacing:
                                                          1.16,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                        'awesome_bonuses'
                                                            .tr,
                                                        style: TextStyle(
                                                          color: Color(
                                                              0xFF64D2FF),
                                                          fontSize: 14.23,
                                                          fontFamily:
                                                          'Poppins',
                                                          fontWeight:
                                                          FontWeight
                                                              .w400,
                                                          letterSpacing:
                                                          1.16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'assets/images/quiz_icon.png'),
                                                height: 20,
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Obx(() => SizedBox(
                                                width: Get.width - 90,
                                                child:
                                                LinearProgressIndicator(
                                                  value: controller
                                                      .deshbordModel
                                                      .value
                                                      ?.result
                                                      ?.quiz
                                                      ?.quizTimeProgress ??
                                                      0,
                                                  minHeight: 10,
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius
                                                          .circular(
                                                          10)),
                                                ),
                                              ))
                                            ],
                                          ),
                                          //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                          SizedBox(
                                            height: 3,
                                          ),
                                          controller
                                              .isMiningProgressComplete
                                              .isTrue
                                              ? QuizAvailable()
                                              : Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            children: [
                                              Text(
                                                'next_quiz'.tr,
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(
                                                      0.6000000238418579),
                                                  fontSize: 13.11,
                                                  fontFamily:
                                                  'Poppins',
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  letterSpacing: 1.07,
                                                ),
                                              ),
                                              Icon(
                                                Icons.access_time,
                                                color:
                                                Color(0xff64D2FF),
                                              ),
                                              Obx(
                                                    () => Text(
                                                  controller
                                                      .quizcountdown
                                                      .value,
                                                  textAlign: TextAlign
                                                      .center,
                                                  style: TextStyle(
                                                    color: Color(
                                                        0xFF64D2FF),
                                                    fontSize: 12.98,
                                                    fontFamily:
                                                    'Poppins',
                                                    fontWeight:
                                                    FontWeight
                                                        .w400,
                                                    letterSpacing:
                                                    0.76,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  PreferenceVisibility(
                                    preferenceKey: Pref.miningEnabledStatus,
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      margin: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xff364156),
                                              Color(0xff212D40)
                                            ]),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 28,
                                              ),
                                              Text(
                                                'extra_reward'.tr,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.23,
                                                  fontFamily: 'Poppins',
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  letterSpacing: 1.16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            children: [
                                              const Image(
                                                image: AssetImage(
                                                    'assets/images/extra_reward_icon.png'),
                                                height: 20,
                                                width: 20,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Obx(() => SizedBox(
                                                  width: Get.width - 90,
                                                  child:
                                                  LinearProgressIndicator(
                                                    value: controller
                                                        .deshbordModel
                                                        .value
                                                        ?.result
                                                        ?.mine
                                                        ?.mineSummary
                                                        ?.sessionProgress ??
                                                        0.0,
                                                    minHeight: 10,
                                                    borderRadius:
                                                    const BorderRadius
                                                        .all(
                                                        Radius.circular(
                                                            10)),
                                                  )))
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                width: 25,
                                              ),
                                              controller
                                                  .isExtraRewardProgressComplete
                                                  .value
                                                  ? ClaimShibaInuButton()
                                                  : Row(
                                                children: [
                                                  Text(
                                                    'mining_progress'
                                                        .tr,
                                                    style: TextStyle(
                                                      color: Colors
                                                          .white
                                                          .withOpacity(
                                                          0.6000000238418579),
                                                      fontSize: 13.11,
                                                      fontFamily:
                                                      'Poppins',
                                                      fontWeight:
                                                      FontWeight
                                                          .w400,
                                                      letterSpacing:
                                                      1.07,
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.access_time,
                                                    color: Color(
                                                        0xff64D2FF),
                                                  ),
                                                  Text(
                                                    ' ${controller.miningHours.value}/${controller.summaryHours.value} HOURS',
                                                    style: TextStyle(
                                                      color: Color(
                                                          0xFF64D2FF),
                                                      fontSize: 11.98,
                                                      fontFamily:
                                                      'Poppins',
                                                      fontWeight:
                                                      FontWeight
                                                          .w400,
                                                      letterSpacing:
                                                      0.76,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 25,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '•Fill 2160 hours target to get 3000 Shiba Inu.',
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 13,
                                                    fontFamily: 'Poppins',
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    letterSpacing: 1.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  PreferenceVisibility(
                                    preferenceKey: Pref.miningEnabledStatus,
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      margin: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xff364156),
                                              Color(0xff212D40)
                                            ]),
                                      ),
                                      child: Obx(
                                            () => Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 28,
                                                ),
                                                Text(
                                                  'extra_reward'.tr,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.23,
                                                    fontFamily: 'Poppins',
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    letterSpacing: 1.16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      'assets/images/extra_reward_icon.png'),
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Obx(
                                                      () => SizedBox(
                                                      width: Get.width - 90,
                                                      child:
                                                      LinearProgressIndicator(
                                                        // value: controller
                                                        //     .deshbordModel
                                                        //     .value
                                                        //     ?.result
                                                        //     ?.quiz
                                                        //     ?.quizSummary
                                                        //     ?.quizSeasonProgress ??
                                                        //     0.0,
                                                        value: (controller
                                                            .quizSessionProgress
                                                            .value) /
                                                            (controller
                                                                .quizSession
                                                                .value),
                                                        minHeight: 10,
                                                        borderRadius:
                                                        BorderRadius
                                                            .all(Radius
                                                            .circular(
                                                            10)),
                                                      )),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            controller
                                                .isQuizProgressComplete
                                                .isTrue
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .start,
                                              children: [
                                                SizedBox(
                                                  width: 25,
                                                ),
                                                ClaimShibaInuButton(),
                                              ],
                                            )
                                                : Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .start,
                                              children: [
                                                SizedBox(
                                                  width: 25,
                                                ),
                                                Text(
                                                  'quiz_progress'.tr,
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white
                                                        .withOpacity(
                                                        0.6000000238418579),
                                                    fontSize: 13.11,
                                                    fontFamily:
                                                    'Poppins',
                                                    fontWeight:
                                                    FontWeight
                                                        .w400,
                                                    letterSpacing:
                                                    1.07,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.access_time,
                                                  color: Color(
                                                      0xff64D2FF),
                                                ),
                                                Text(
                                                  ' ${controller.quizSessionProgress.value}/${controller.quizSession.value}',
                                                  style: TextStyle(
                                                    color: Color(
                                                        0xFF64D2FF),
                                                    fontSize: 11.98,
                                                    fontFamily:
                                                    'Poppins',
                                                    fontWeight:
                                                    FontWeight
                                                        .w400,
                                                    letterSpacing:
                                                    0.76,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 25,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '•Complete 1800 quiz to get 2000 Shiba Inu.',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 13,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      letterSpacing: 1.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  PreferenceVisibility(
                                    preferenceKey: Pref.miningEnabledStatus,
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      margin: EdgeInsets.all(12),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color(0xff364156),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.person_add,
                                                color: Color(0xFF61C7C4),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'refer_now'.tr,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.23,
                                                    fontFamily: 'Poppins',
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    letterSpacing: 0.14,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (controller
                                                  .isMinings.isFalse &&
                                                  controller.isMiningEnabled
                                                      .isTrue) {
                                                errorSnack(
                                                    'Please start mining first');
                                                return;
                                              }
                                              mainPageController
                                                  .selectedBottomBarItem
                                                  .value = PageName.team;
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 28,
                                                ),
                                                Text(
                                                  'start_inviting'.tr,
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                    color:
                                                    Color(0xFF64D2FF),
                                                    fontSize: 13.22,
                                                    fontFamily: 'Poppins',
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    letterSpacing: 0.14,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.chevron_right,
                                                  color: Color(0xff64D2FF),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  PreferenceVisibility(
                                    preferenceKey: Pref.miningEnabledStatus,
                                    child: Container(
                                      margin: EdgeInsets.all(12),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'my_team'.tr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.25,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.14,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (controller
                                                  .isMinings.isFalse &&
                                                  controller.isMiningEnabled
                                                      .isTrue) {
                                                errorSnack(
                                                    'Please start mining first');
                                                return;
                                              }
                                              Get.to(() =>
                                                  GetAllTeamMembersPage());
                                            },
                                            child: Text(
                                              'more'.tr,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Color(0xFF64D2FF),
                                                fontSize: 13.22,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.14,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  PreferenceVisibility(
                                    preferenceKey: Pref.miningEnabledStatus,
                                    child: Builder(builder: (context) {
                                      if (controller
                                          .deshbordModel
                                          .value
                                          ?.result
                                          ?.team
                                          ?.teamMembers
                                          ?.teamMembers ==
                                          null) {
                                        return Container();
                                      } else if (controller
                                          .deshbordModel
                                          .value
                                          ?.result
                                          ?.team
                                          ?.teamMembers
                                          ?.teamMembers !=
                                          null &&
                                          controller
                                              .deshbordModel
                                              .value!
                                              .result!
                                              .team!
                                              .teamMembers!
                                              .teamMembers!
                                              .length <
                                              index) {
                                        index = controller
                                            .deshbordModel
                                            .value!
                                            .result!
                                            .team!
                                            .teamMembers!
                                            .teamMembers!
                                            .length;
                                      }
                                      return Wrap(
                                        alignment: WrapAlignment.start,
                                        children: [
                                          if (controller
                                              .deshbordModel
                                              .value
                                              ?.result
                                              ?.team
                                              ?.teamMembers
                                              ?.teamMembers !=
                                              null)
                                            for (var teamMember
                                            in controller
                                                .deshbordModel
                                                .value
                                                ?.result
                                                ?.team
                                                ?.teamMembers
                                                ?.teamMembers!
                                                .sublist(
                                                0, index) ??
                                                [])
                                              Padding(
                                                padding: EdgeInsets.all(2),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            10)),
                                                    gradient: LinearGradient(
                                                        begin: Alignment
                                                            .topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Color(0xff364156),
                                                          Color(0xff212D40)
                                                        ]),
                                                  ),
                                                  width: Get.width * 0.17,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                30),
                                                            child:
                                                            const Image(
                                                              height: 40,
                                                              width: 40,
                                                              image: AssetImage(
                                                                  'assets/images/avatar.png'),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 5),
                                                          // Adjust this value as needed for spacing
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              // Adjust this value as needed for spacing
                                                              Container(
                                                                width: 8,
                                                                height: 8,
                                                                decoration:
                                                                ShapeDecoration(
                                                                  color: teamMember.isMining ==
                                                                      false
                                                                      ? Color(
                                                                      0x1A61C7C4)
                                                                      : Color(
                                                                      0xFF61C7C4),
                                                                  shape:
                                                                  CircleBorder(),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        ],
                                      );
                                    }),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
      );
    });
  }

  /*  Future<void> startMining() async {
    if (controller.isMiningEnabled.isTrue) {
      await controller.startMining();
    } else {
      Get.to(() => QuizHomePage());
    }
  }*/

  Future<void> startMining() async {
    if (controller.isMiningEnabled.isTrue) {
      await controller.startMining();
    } else {
      Get.to(() => QuizHomePage());
    }
  }

  Future<bool> _showMiningDisclaimerDialog() async {
    if (!controller.isMiningEnabled.isTrue) {
      return true;
    }
    bool disableDisclaimer = false;
    final prefs = await SharedPreferences.getInstance();
    final bool showDisclaimer = prefs.getBool('showMiningDisclaimer') ?? true;

    if (!showDisclaimer) return true;

    return await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Important Notice", style: TextStyle(fontWeight: FontWeight.bold)),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "This app does NOT perform cryptocurrency mining on your device. It is remotely updating to our server.",
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
                // const SizedBox(height: 16),
                // const Divider(),
                // const SizedBox(height: 12),
                // const Text(
                //   "Key Points:",
                //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                // ),
                // const SizedBox(height: 8),
                // _buildBulletPoint("No real cryptocurrency is generated or stored"),
                // _buildBulletPoint("No device resources (CPU, battery) are used"),
                // _buildBulletPoint("Simulated values have no monetary value"),
                // _buildBulletPoint("No connection to blockchain networks"),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: disableDisclaimer,
                      onChanged: (val) => setState(() => disableDisclaimer = val ?? false),
                    ),
                    const Text("Don't show this message again",
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Exit"),
          ),
          TextButton(
            onPressed: () async {
              await prefs.setBool('showMiningDisclaimer', !disableDisclaimer);
              Get.back(result: true);
            },
            child: const Text("Proceed"),
          ),
        ],
      ),
      barrierDismissible: false,
    ) ?? false;
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }


/*  Future<void> initAd() async {
    await InterstitialAd.load(
        */ /* Real Ad Unit Id */ /*
        adUnitId: "ca-app-pub-9323045181924630/7438005611",
        */ /* Real Ad Unit Id */ /*

        */ /* Test Ad Unit Id */ /*
        // adUnitId: "ca-app-pub-3940256099942544/1033173712",

        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          //  ad.show();
          interstitialAd = ad;
          isAdLoaded = true;
          print("isAdEnabled1122: load ad");
          //  controller.isAdLoaded.value = true;
          interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) async {
            print("isAdEnabled1122: Dismiss ad");
            await interstitialAd.dispose();
          }, onAdFailedToShowFullScreenContent: (ad, err) async {
            await interstitialAd.dispose();
            print("isAdEnabled1122: Error: $err");
            await initAd();
          });
        }, onAdFailedToLoad: (err) async {
          print("isAdEnabled1122: Error2: $err");
          await interstitialAd.dispose();
          // controller.isAdLoaded.value = false;
          isAdLoaded = false;
          await initAd();
        }));
  }*/
}