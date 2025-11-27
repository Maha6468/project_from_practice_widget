// To parse this JSON data, do
//
//     final resetPAsswordModel = resetPAsswordModelFromJson(jsonString);

import 'dart:convert';

ResetPasswordModel resetPAsswordModelFromJson(String str) => ResetPasswordModel.fromJson(json.decode(str));

String resetPAsswordModelToJson(ResetPasswordModel data) => json.encode(data.toJson());

class ResetPasswordModel {
  final String? result;
  final int? statusCode;

  ResetPasswordModel({
    this.result,
    this.statusCode,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) => ResetPasswordModel(
    result: json["result"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "statusCode": statusCode,
  };
}