// To parse this JSON data, do
//
//     final registerTokenModel = registerTokenModelFromJson(jsonString);

import 'dart:convert';

RegisterTokenModel registerTokenModelFromJson(String str) => RegisterTokenModel.fromJson(json.decode(str));

String registerTokenModelToJson(RegisterTokenModel data) => json.encode(data.toJson());

class RegisterTokenModel {
  final String? result;
  final int? statusCode;

  RegisterTokenModel({
    this.result,
    this.statusCode,
  });

  factory RegisterTokenModel.fromJson(Map<String, dynamic> json) => RegisterTokenModel(
    result: json["result"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "statusCode": statusCode,
  };
}