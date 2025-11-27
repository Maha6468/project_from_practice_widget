// To parse this JSON data, do
//
//     final joinReferalModel = joinReferalModelFromJson(jsonString);

import 'dart:convert';

JoinReferalModel joinReferalModelFromJson(String str) => JoinReferalModel.fromJson(json.decode(str));

String joinReferalModelToJson(JoinReferalModel data) => json.encode(data.toJson());

class JoinReferalModel {
  final String? result;
  final int? statusCode;

  JoinReferalModel({
    this.result,
    this.statusCode,
  });

  factory JoinReferalModel.fromJson(Map<String, dynamic> json) => JoinReferalModel(
    result: json["result"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "statusCode": statusCode,
  };
}