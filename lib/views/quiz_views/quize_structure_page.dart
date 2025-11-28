import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../ads/AdManager.dart';
import '../../colors/app_colors.dart';
import '../../common/perfrance.dart';
import '../../controllers/quiz_controller.dart';
import '../../models/quiz_model.dart';
import '../widgets/dialogs.dart';

class QuizStructurePage extends StatefulWidget {
  const QuizStructurePage({super.key});

  @override
  State<QuizStructurePage> createState() => _QuizStructurePageState();
}

class _QuizStructurePageState extends State<QuizStructurePage> {
  final QuizController controller = Get.put(QuizController());

  late InterstitialAd interstitialAd;

  bool isAdLoaded = false;

  Question? question;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    controller.question.value = question?.question ?? "";
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initAd();

    });
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (controller.timer.isActive || controller.timer.isPaused) {
          print("Sakib Checking timer is Active");
          controller.timer.cancel();
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.appSecondaryBackgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.appSecondaryColor,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Image(
                    image: AssetImage('assets/images/appbar_back_arrow.png'),
                    height: 32,
                    width: 32,
                  )),
            ),
            title: const Text(
              'Learn and Earn',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.59,
              ),
            ),
          ),
          body: Obx(
                () {
              if (controller.currentIndex.value != 0 &&
                  controller.currentIndex.value < 6) {
                if (controller.solveQuestionModel.value == null) {
                  question = controller.quizModel.value?.result?.question;

                  controller.questionId.value =
                      question?.id ?? "Something went wrong.";

                  controller.question.value =
                  controller.quizModel.value!.result!.question!.question!;
                  print("Question Sakib ELSE: ${question?.question}");
                } else {
                  try {
                    question = controller
                        .solveQuestionModel.value!.result!.nextQuestion!;

                    controller.questionId.value =
                        question?.id ?? "Something went wrong.";
                    controller.question.value = controller.solveQuestionModel
                        .value!.result!.nextQuestion!.question!;
                  } catch (e) {
                    print("Sakib quiz error $e");
                  }
                }
              }
              if (controller.currentIndex.value > 5) {
                return const Center(
                  child: Text(
                    'No more questions!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Text(
                          // controller.currentIndex.value <= 4 ? (controller.currentIndex.value + 1).toString() : 5.toString(),
                          controller.currentIndex.value.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.59,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Obx(
                                () => Text(
                              controller.question.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.59,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                          () => Container(
                        decoration: BoxDecoration(
                            color: controller.selectedId.value != 0
                                ? AppColors.appBackgroundColor
                                : AppColors.appSecondaryColor,
                            borderRadius:
                            BorderRadius.all(Radius.circular(100.0))),
                        child: Obx(
                              () => RadioListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(100.0))),
                              activeColor: controller.selectedId.value == 0
                                  ? Colors.white
                                  : null,
                              value: 0,
                              groupValue: controller.selectedId.value,
                              title: Text(
                                "a) ${question?.option1 ?? ""}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.59,
                                ),
                              ),
                              onChanged: controller.disableRadioButtons.value
                                  ? null
                                  : (value) {
                                controller.answer.value =
                                    question?.option1 ?? "";

                                controller.selectedId.value =
                                value! as int;
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                          () => Container(
                        decoration: BoxDecoration(
                            color: controller.selectedId.value != 1
                                ? AppColors.appBackgroundColor
                                : AppColors.appSecondaryColor,
                            borderRadius:
                            BorderRadius.all(Radius.circular(100.0))),
                        child: Obx(
                              () => RadioListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(100.0))),
                              activeColor: controller.selectedId.value == 1
                                  ? Colors.white
                                  : null,
                              value: 1,
                              groupValue: controller.selectedId.value,
                              title: Text(
                                "b) ${question?.option2 ?? ""}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.59,
                                ),
                              ),
                              onChanged: controller.disableRadioButtons.value
                                  ? null
                                  : (value) {
                                controller.answer.value =
                                    question?.option2 ?? "";
                                controller.selectedId.value =
                                value! as int;
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                          () => Container(
                        decoration: BoxDecoration(
                            color: controller.selectedId.value != 2
                                ? AppColors.appBackgroundColor
                                : AppColors.appSecondaryColor,
                            borderRadius:
                            BorderRadius.all(Radius.circular(100.0))),
                        child: Obx(
                              () => RadioListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(100.0))),
                              activeColor: Colors.white,
                              value: 2,
                              groupValue: controller.selectedId.value,
                              title: Text(
                                "c) ${question?.option3 ?? ""}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.59,
                                ),
                              ),
                              onChanged: controller.disableRadioButtons.value
                                  ? null
                                  : (value) {
                                controller.answer.value =
                                    question?.option3 ?? "";
                                controller.selectedId.value =
                                value! as int;
                                print(
                                    "Current Index: ${controller.currentIndex.value}");
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                          () => Container(
                        decoration: BoxDecoration(
                            color: controller.selectedId.value != 3
                                ? AppColors.appBackgroundColor
                                : AppColors.appSecondaryColor,
                            borderRadius:
                            BorderRadius.all(Radius.circular(100.0))),
                        child: Obx(
                              () => RadioListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(100.0))),
                              activeColor: Colors.white,
                              value: 3,
                              groupValue: controller.selectedId.value,
                              title: Text(
                                "d) ${question?.option4 ?? ""}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.59,
                                ),
                              ),
                              onChanged: controller.disableRadioButtons.value
                                  ? null
                                  : (value) {
                                controller.answer.value =
                                    question?.option4 ?? "";
                                controller.selectedId.value =
                                value! as int;
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: Text(
                          "Quiz Progress:- ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.59,
                          ),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: Obx(
                                  () => CircularProgressIndicator(
                                backgroundColor: Color(0xffF2F4F7),
                                value: (controller.progress.value),
                                strokeWidth: 7,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Obx(
                                    () => Text(
                                  '${controller.currentIndex.value}/5',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: (!controller.isMiningEnabled.value || controller.isAdLoaded.value),
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            // Isolate.spawn(submitAnswer, context);
                            submitAnswer(context);
                          },
                          child: Container(
                            width: Get.width / 1.3,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            // margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.appSecondaryColor,
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Center(
                              child: Text(
                                'SUBMIT ANSWER',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.59,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }

  void showResult(BuildContext context) {
    print("finished");
    final action = Dialogs.quizResultDialog(
        context, controller.correct.value, controller.wrong.value);
  }

  Future<void> initAd() async {
    var isAdEnabled = await PreferenceHelper.instance.getData(Pref.isAdEnabled) ?? false;
    if (!isAdEnabled) {
      isAdLoaded = true;
      controller.isAdLoaded.value = true;
      return;
    }

    bool isAdReady =
    await AdManager.instance.isAdReady();
    if (isAdReady) {
      isAdLoaded = true;
      controller.isAdLoaded.value = true;
    }

/*    await InterstitialAd.load(
         Real Ad Unit Id
        adUnitId: "ca-app-pub-9323045181924630/7438005611",
         Real Ad Unit Id

         Test Ad Unit Id
        // adUnitId: "ca-app-pub-3940256099942544/1033173712",
         Test Ad Unit Id
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          //  ad.show();
          interstitialAd = ad;
          // interstitialAd.value.show();
          print("Sakib load ad");
          //  controller.isAdLoaded.value = true;
          isAdLoaded = true;
          controller.isAdLoaded.value = true;
          interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) async {
            controller.isAdLoaded.value = false;
            controller.disableRadioButtons.value = false;
            print("Sakib Dismiss ad");
            await interstitialAd.dispose();
            await initAd();
          }, onAdFailedToShowFullScreenContent: (ad, err) async {
            controller.isAdLoaded.value = false;
            await interstitialAd.dispose();
            print("SAKIBHOSSAINSKB: $err");
            await initAd();
          });
        }, onAdFailedToLoad: (err) async {
          print("SakibSakibSakib: $err");
          await interstitialAd.dispose();
          // controller.isAdLoaded.value = false;
          isAdLoaded = false;
          controller.isAdLoaded.value = false;
          await initAd();
        }));*/
  }

  submitAnswer(context) async {
    var isAdEnabled = await PreferenceHelper.instance.getData(Pref.isAdEnabled) ?? false;

    controller.disableRadioButtons.value = false;
    // initAd();
    controller.isTapped.value = true;
    print("currentIndex: ${controller.currentIndex.value}");

    if (controller.selectedId.value == 4) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('please_select_an_option'.tr)));
    } else if (controller.currentIndex.value < 6) {
      print("timer112244: isActive: ${controller.timer.isActive}");
      print("timer112244: isPaused: ${controller.timer.isPaused}");
      var answerId = controller.answer.value;
      if (!controller.timer.isActive) {
        answerId = "-1";
      }

      controller.timer.pause();
      //showLoading();
      //show it again
      print("isAdEnabled1122: quiz: isAdEnabled: $isAdEnabled");
      print("isAdEnabled1122: quiz: isAdLoaded: $isAdLoaded");
      if (isAdEnabled) {
        // await interstitialAd.show();
        bool isAdReady =
        await AdManager.instance.isAdReady();
        if (isAdReady) {
          await AdManager.instance.showAd();
        }
      }


      //hideLoading();
      controller.timer.start();
      controller.progress.value = 0.0;
      // controller.currentIndex.value++;

      await controller.solveQuestion(
          quizJobId: controller.quizJobId.value,
          answer: answerId,
          questionId: controller.questionId.value,
          context: context,
          isShow: true);
      question = controller.solveQuestionModel.value!.result!.nextQuestion!;
      controller.question.value =
      controller.solveQuestionModel.value!.result!.nextQuestion!.question!;
      controller.selectedId.value = 4;
      print("controller.currentIndex.value: ${controller.currentIndex.value}");
      controller.correct.value =
      controller.solveQuestionModel.value!.result!.totalCorrectAnswers!;
      controller.wrong.value =
      controller.solveQuestionModel.value!.result!.totalWrongAnswers!;

    }
    await initAd();
  }
}


//maha
extension on Function() {
  Future getData(String isAdEnabled) async {}
}