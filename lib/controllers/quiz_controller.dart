//import 'dart:async';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/app_loading.dart';
import '../common/firebase_notification/main dart configration.txt.dart' as PreferenceHelper;
import '../common/global_widget.dart';
import '../common/perfrance.dart';
import '../common/string.dart';
import '../data/repo/repo.dart';
import '../models/quiz_model.dart';
import '../models/solve_question.dart';
import '../views/widgets/dialogs.dart';

class QuizController extends GetxController {
  var answerIdInt = 0.obs;
  var selectedId = 4.obs;
  var quizRemaining = 5.obs;
  var quizModel = Rx<QuizModel?>(null);
  var solveQuestionModel = Rx<SolveQuestion?>(null);
  var currentIndex = 0.obs;
  var correct = 0.obs;
  var wrong = 0.obs;
  var quizJobId = "".obs;
  var answer = "".obs;
  var question = "".obs;
  var questionId = "".obs;
  var timerFlag = true.obs;
  RxDouble progress = 0.0.obs;
  late PausableTimer timer;
  var isTapped = false.obs;
  var disableRadioButtons = false.obs;
  var isAdLoaded = false.obs;
  var isLeftQuiz = false.obs;
  late SharedPreferences prefs;
  var isMiningEnabled = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
/*    prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(AppString.quizQuestion)){
     currentIndex.value = prefs.getInt('index') ?? 1;
     correct.value = prefs.getInt('correct') ?? 0;
     wrong.value = prefs.getInt('wrong') ?? 0;
     quizJobId.value = prefs.getString("quizJobId") ?? "";
     questionId.value = prefs.getString('questionId') ?? "";
     isLeftQuiz.value = true;
    }*/

    getMiningStatus();
  }

  Future<void> startQuiz() async {
    // if (!isLeftQuiz.value){
    try {
      //showLoading();
      await UserRepo.getInstance().startQuiz().then((response) {
        response.fold((l) {
          errorSnack(l.errorMessage.toString());
          hideLoading();
        }, (r) async {
          print("start_quizL: $r");
          quizModel.value = r;
          print("Sakib Solve: $r");
          if (r.result?.question != null) {
            print("Debug Sakib r2");
            quizJobId.value = r.result!.quizJobId ?? "";
            currentIndex.value = r.result!.questionIndex!;
            questionId.value = r.result!.question!.id!;
          }
          hideLoading();
        });
      });
    } catch (e) {
      errorSnack("$e");
      hideLoading();
    } finally {
      hideLoading();
    }
    // }
  }

  Future<void> solveQuestion({quizJobId, questionId, answer, context, required isShow}) async {
    print("SolveQuestion called");
    try {
      showLoading();
      await UserRepo.getInstance().solveQuestion(
        data: {
          "quizJobId": quizJobId,
          "questionId": questionId,
          "answer": answer
        },
      ).then((response) {
        print("Sakib Response: $response");
        response.fold((l) {
          print("Sakib fold l");
          errorSnack(l.errorMessage.toString());
          hideLoading();
        }, (r) async {
          //currentIndex.value++;
          print("Baghu : $r");
          solveQuestionModel.value = r;

          var ques = solveQuestionModel.value?.result?.nextQuestion;
          var ans = solveQuestionModel.value?.result?.correctAnswer ?? false;
          if(isShow) {
            if (ans == true) {
              final action = Dialogs.quizAnswerDialog(
                  context,
                  "Correct Answer",
                  'Congratulations! Your answer is correct...',
                  Icons.check_circle_outlined,
                  true,
                  currentIndex.value);

              action.then((value) async {
                print("Dialog closed with value: $value");
                print("Current Index: $currentIndex");
                currentIndex.value = r.result?.nextQuestionIndex ?? 0;

                if (value.name == "cancel") {
                  if (currentIndex.value == 6 || ques == null) {
                    var correct =
                        solveQuestionModel.value?.result?.totalCorrectAnswers ?? 0;
                    var wrong =
                        solveQuestionModel.value?.result?.totalWrongAnswers ?? 0;
                    final action = Dialogs.quizResultDialog(context, correct, wrong);
                    timer.cancel();
                    //await prefs.remove('index');
                  } else {
                    progress.value = 0.0;
                  }
                }
              });
            } else {
              final action = Dialogs.quizAnswerDialog(
                  context,
                  "Wrong Answer",
                  'Ohh, Sorry! Your answer is wrong, Try next...',
                  FontAwesomeIcons.circleXmark,
                  false, currentIndex.value);
              action.then((value) async {
                // This code block will execute after the quizAnswerDialog is closed
                // You can open your second dialog here
                currentIndex.value = r.result!.nextQuestionIndex!;
                if (value.name == "cancel") {
                  if (currentIndex.value == 6 || ques == null) {
                    var correct =
                        solveQuestionModel.value!.result!.totalCorrectAnswers ??
                            0;
                    var wrong =
                        solveQuestionModel.value!.result!.totalWrongAnswers ?? 0;
                    final action =
                    Dialogs.quizResultDialog(context, correct, wrong,);
                  } else {
                    progress.value = 0.0;
                    // nextQuestion();
                    /*await solveQuestion(
                      quizJobId: quizJobId,
                      questionId: questionId,
                      context: context);*/
                  }
                }
              });
            }
          }
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

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = PausableTimer.periodic(oneSec, () async {
      if (progress.value >= 1.0) {
        disableRadioButtons.value = true;
        selectedId.value = 5;
        //progress.value = 0.0;
        if (currentIndex.value < 6 && isTapped.value) {
          isTapped.value = false;
          // currentIndex.value++;
          //  await solveQuestion(
          //      quizJobId: quizJobId.value,
          //      answer: answer.value,
          //      questionId: questionId.value,
          //      context: Get.context);
          question.value =
              solveQuestionModel.value?.result?.nextQuestion?.question ?? "";
          selectedId.value = 4;
          print("controller.currentIndex.value: ${currentIndex.value}");
          correct.value =
              solveQuestionModel.value?.result?.totalCorrectAnswers ?? 0;
          wrong.value = solveQuestionModel.value?.result?.totalWrongAnswers ?? 0;
        } else {
          timer.pause();
        }
      } else {
        if (currentIndex.value == 6){
          timer.cancel();
        }
        else {
          progress.value += 1 / 60;
        }
      }
    });
    timer.start();
  }

  @override
  void onClose() {
    timer.cancel();

  }

  Future<void> getMiningStatus() async {
    try {
      bool? visibility = await PreferenceHelper.instance.getData(Pref.miningEnabledStatus);
      isMiningEnabled.value = visibility ?? true;
      if (isMiningEnabled.value == true) {
        isAdLoaded.value = true;
      }
    } catch (e) {
      isMiningEnabled.value = true;
      print("Error loading preference: $e");
    }
  }
}