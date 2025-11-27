// To parse this JSON data, do
//
//     final startminingModel = startminingModelFromJson(jsonString);

import 'dart:convert';

StartminingModel startminingModelFromJson(String str) => StartminingModel.fromJson(json.decode(str));

String startminingModelToJson(StartminingModel data) => json.encode(data.toJson());

class StartminingModel {
  final String? result;
  final int? statusCode;

  StartminingModel({
    this.result,
    this.statusCode,
  });

  factory StartminingModel.fromJson(Map<String, dynamic> json) => StartminingModel(
    result: json["result"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "statusCode": statusCode,
  };
}