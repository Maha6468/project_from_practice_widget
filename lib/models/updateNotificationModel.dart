// To parse this JSON data, do
//
//     final updateNotificationModel = updateNotificationModelFromJson(jsonString);

import 'dart:convert';

UpdateNotificationModel updateNotificationModelFromJson(String str) => UpdateNotificationModel.fromJson(json.decode(str));

String updateNotificationModelToJson(UpdateNotificationModel data) => json.encode(data.toJson());

class UpdateNotificationModel {
  final String? result;
  final int? statusCode;

  UpdateNotificationModel({
    this.result,
    this.statusCode,
  });

  factory UpdateNotificationModel.fromJson(Map<String, dynamic> json) => UpdateNotificationModel(
    result: json["result"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "statusCode": statusCode,
  };
}