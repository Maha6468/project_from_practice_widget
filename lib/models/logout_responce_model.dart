// To parse this JSON data, do
//
//     final logoutResponceModel = logoutResponceModelFromJson(jsonString);

import 'dart:convert';

LogoutResponceModel logoutResponceModelFromJson(String str) => LogoutResponceModel.fromJson(json.decode(str));

String logoutResponceModelToJson(LogoutResponceModel data) => json.encode(data.toJson());

class LogoutResponceModel {
  final String? result;
  final int? statusCode;

  LogoutResponceModel({
    this.result,
    this.statusCode,
  });

  factory LogoutResponceModel.fromJson(Map<String, dynamic> json) => LogoutResponceModel(
    result: json["result"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "statusCode": statusCode,
  };
}