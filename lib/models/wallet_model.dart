// To parse this JSON data, do
//
//     final walletResponseModel = walletResponseModelFromJson(jsonString);

import 'dart:convert';

WalletResponseModel walletResponseModelFromJson(String str) => WalletResponseModel.fromJson(json.decode(str));

String walletResponseModelToJson(WalletResponseModel data) => json.encode(data.toJson());

class WalletResponseModel {
  final Result? result;
  final int? statusCode;

  WalletResponseModel({
    this.result,
    this.statusCode,
  });

  factory WalletResponseModel.fromJson(Map<String, dynamic> json) => WalletResponseModel(
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result?.toJson(),
    "statusCode": statusCode,
  };
}

class Result {
  final QuizSummary? quizSummary;
  final AciTokens? aciTokens;
  final RewardTokens? rewardTokens;
  final MiningSummary? miningSummary;

  Result({
    this.quizSummary,
    this.aciTokens,
    this.rewardTokens,
    this.miningSummary,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    quizSummary: json["quizSummary"] == null ? null : QuizSummary.fromJson(json["quizSummary"]),
    aciTokens: json["aciTokens"] == null ? null : AciTokens.fromJson(json["aciTokens"]),
    rewardTokens: json["rewardTokens"] == null ? null : RewardTokens.fromJson(json["rewardTokens"]),
    miningSummary: json["miningSummary"] == null ? null : MiningSummary.fromJson(json["miningSummary"]),
  );

  Map<String, dynamic> toJson() => {
    "quizSummary": quizSummary?.toJson(),
    "aciTokens": aciTokens?.toJson(),
    "rewardTokens": rewardTokens?.toJson(),
    "miningSummary": miningSummary?.toJson(),
  };
}

class AciTokens {
  final double? miningQuizTokens;
  final double? referralTokens;

  AciTokens({
    this.miningQuizTokens,
    this.referralTokens,
  });

  factory AciTokens.fromJson(Map<String, dynamic> json) => AciTokens(
    miningQuizTokens: json["miningQuizTokens"]?.toDouble(),
    referralTokens: json["referralTokens"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "miningQuizTokens": miningQuizTokens,
    "referralTokens": referralTokens,
  };
}

class MiningSummary {
  final int? summaryHours;
  final int? miningHours;
  final double? sessionProgress;

  MiningSummary({
    this.summaryHours,
    this.miningHours,
    this.sessionProgress,
  });

  factory MiningSummary.fromJson(Map<String, dynamic> json) => MiningSummary(
    summaryHours: json["summaryHours"],
    miningHours: json["miningHours"],
    sessionProgress: json["sessionProgress"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "summaryHours": summaryHours,
    "miningHours": miningHours,
    "sessionProgress": sessionProgress,
  };
}

class QuizSummary {
  int? quizSeason = 300;
  int? totalSolvedQuiz = 0;
  final int? quizSeasonProgress;

  QuizSummary({
    this.quizSeason,
    this.totalSolvedQuiz,
    this.quizSeasonProgress,
  });

  factory QuizSummary.fromJson(Map<String, dynamic> json) => QuizSummary(
    quizSeason: json["quizSeason"],
    totalSolvedQuiz: json["totalSolvedQuiz"],
    quizSeasonProgress: json["quizSeasonProgress"],
  );

  Map<String, dynamic> toJson() => {
    "quizSeason": quizSeason,
    "totalSolvedQuiz": totalSolvedQuiz,
    "quizSeasonProgress": quizSeasonProgress,
  };
}

class RewardTokens {
  final double? rewardTokens;

  RewardTokens({
    this.rewardTokens,
  });

  factory RewardTokens.fromJson(Map<String, dynamic> json) => RewardTokens(
    rewardTokens: json["rewardTokens"],
  );

  Map<String, dynamic> toJson() => {
    "rewardTokens": rewardTokens?.toDouble(),
  };
}