// To parse this JSON data, do
//
//     final deleteAccountModel = deleteAccountModelFromJson(jsonString);

import 'dart:convert';

DeleteAccountModel deleteAccountModelFromJson(String str) => DeleteAccountModel.fromJson(json.decode(str));

String deleteAccountModelToJson(DeleteAccountModel data) => json.encode(data.toJson());

class DeleteAccountModel {
  final String? result;
  final int? statusCode;

  DeleteAccountModel({
    this.result,
    this.statusCode,
  });

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) => DeleteAccountModel(
    result: json["result"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "statusCode": statusCode,
  };
}