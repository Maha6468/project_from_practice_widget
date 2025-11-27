// To parse this JSON data, do
//
//     final supportResponceModel = supportResponceModelFromJson(jsonString);

import 'dart:convert';

SupportResponceModel supportResponceModelFromJson(String str) => SupportResponceModel.fromJson(json.decode(str));

String supportResponceModelToJson(SupportResponceModel data) => json.encode(data.toJson());

class SupportResponceModel {
  final Result? result;
  final int? statusCode;

  SupportResponceModel({
    this.result,
    this.statusCode,
  });

  factory SupportResponceModel.fromJson(Map<String, dynamic> json) => SupportResponceModel(
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result?.toJson(),
    "statusCode": statusCode,
  };
}

class Result {
  final String? key;
  final String? value;

  Result({
    this.key,
    this.value,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}