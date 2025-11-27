// To parse this JSON data, do
//
//     final loginResponceModel = loginResponceModelFromJson(jsonString);

import 'dart:convert';

LoginResponceModel loginResponceModelFromJson(String str) => LoginResponceModel.fromJson(json.decode(str));

String loginResponceModelToJson(LoginResponceModel data) => json.encode(data.toJson());

class LoginResponceModel {
  Result? result;
  int? statusCode;

  LoginResponceModel({
    this.result,
    this.statusCode,
  });

  factory LoginResponceModel.fromJson(Map<String, dynamic> json) => LoginResponceModel(
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result?.toJson(),
    "statusCode": statusCode,
  };
}

class Result {
  String? accessToken;

  Result({
    this.accessToken,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    accessToken: json["accessToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
  };
}