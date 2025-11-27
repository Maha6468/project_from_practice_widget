// To parse this JSON data, do
//
//     final errorResponseModel = errorResponseModelFromJson(jsonString);

import 'dart:convert';

ErrorResponseModel errorResponseModelFromJson(String str) => ErrorResponseModel.fromJson(json.decode(str));

String errorResponseModelToJson(ErrorResponseModel data) => json.encode(data.toJson());

class ErrorResponseModel {
  final String? errorMessage;
  final int? statusCode;

  ErrorResponseModel({
    this.errorMessage,
    this.statusCode,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) => ErrorResponseModel(
    errorMessage: json["result"]["ErrorMessage"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "ErrorMessage": errorMessage,
    "statusCode": statusCode,
  };
}