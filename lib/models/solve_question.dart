// To parse this JSON data, do
//
//     final solveQuestion = solveQuestionFromJson(jsonString);

import 'dart:convert';

import 'package:project_from_practice_widget/models/quiz_model.dart';


SolveQuestion solveQuestionFromJson(String str) => SolveQuestion.fromJson(json.decode(str));

String solveQuestionToJson(SolveQuestion data) => json.encode(data.toJson());

class SolveQuestion {
  Result? result;
  int? statusCode;

  SolveQuestion({this.result, this.statusCode});

  SolveQuestion.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Result {
  int? totalWrongAnswers;
  String? message;
  int? timeToSolveInMiliseconds;
  int? totalCorrectAnswers;
  bool? correctAnswer;
  Question? nextQuestion;
  int? nextQuestionIndex;

  Result(
      {this.totalWrongAnswers,
        this.message,
        this.timeToSolveInMiliseconds,
        this.totalCorrectAnswers,
        this.correctAnswer,
        this.nextQuestion,
        this.nextQuestionIndex
      });

  Result.fromJson(Map<String, dynamic> json) {
    totalWrongAnswers = json['TotalWrongAnswers'];
    message = json['Message'];
    timeToSolveInMiliseconds = json['TimeToSolveInMiliseconds'];
    totalCorrectAnswers = json['TotalCorrectAnswers'];
    correctAnswer = json['CorrectAnswer'];
    nextQuestion = json['NextQuestion'] != null
        ? new Question.fromJson(json['NextQuestion'])
        : null;
    nextQuestionIndex = json['NextQuestionIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalWrongAnswers'] = this.totalWrongAnswers;
    data['Message'] = this.message;
    data['TimeToSolveInMiliseconds'] = this.timeToSolveInMiliseconds;
    data['TotalCorrectAnswers'] = this.totalCorrectAnswers;
    data['CorrectAnswer'] = this.correctAnswer;
    if (this.nextQuestion != null) {
      data['NextQuestion'] = this.nextQuestion!.toJson();
    }
    data['NextQuestionIndex'] = this.nextQuestionIndex;
    return data;
  }
}

// class NextQuestion {
//   String? id;
//   String? question;
//   String? option1;
//   String? option2;
//   String? option3;
//   String? option4;
//
//   NextQuestion(
//       {this.id,
//         this.question,
//         this.option1,
//         this.option2,
//         this.option3,
//         this.option4});
//
//   NextQuestion.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     question = json['question'];
//     option1 = json['option1'];
//     option2 = json['option2'];
//     option3 = json['option3'];
//     option4 = json['option4'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['question'] = this.question;
//     data['option1'] = this.option1;
//     data['option2'] = this.option2;
//     data['option3'] = this.option3;
//     data['option4'] = this.option4;
//     return data;
//   }
// }
