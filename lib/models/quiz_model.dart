// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

import 'dart:convert';

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String quizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  Result? result;
  int? statusCode;

  QuizModel({this.result, this.statusCode});

  QuizModel.fromJson(Map<String, dynamic> json) {
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
  String? quizJobId;
  int? questionIndex;
  Question? question;

  Result({this.quizJobId, this.question});

  Result.fromJson(Map<String, dynamic> json) {
    quizJobId = json['QuizJobId'];
    questionIndex = json['QuestionIndex'];
    question = json['Question'] != null
        ? new Question.fromJson(json['Question'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['QuizJobId'] = this.quizJobId;
    data['QuestionIndex'] = this.questionIndex;
    if (this.question != null) {
      data['Question'] = this.question!.toJson();
    }
    return data;
  }
}

class Question {
  String? id;
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? option4;

  Question(
      {this.id,
        this.question,
        this.option1,
        this.option2,
        this.option3,
        this.option4});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    option1 = json['option1'];
    option2 = json['option2'];
    option3 = json['option3'];
    option4 = json['option4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['option1'] = this.option1;
    data['option2'] = this.option2;
    data['option3'] = this.option3;
    data['option4'] = this.option4;
    return data;
  }
}
