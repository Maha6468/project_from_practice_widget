// To parse this JSON data, do
//
//     final transferCoinModel = transferCoinModelFromJson(jsonString);

import 'dart:convert';

TransferCoinModel transferCoinModelFromJson(String str) => TransferCoinModel.fromJson(json.decode(str));

String transferCoinModelToJson(TransferCoinModel data) => json.encode(data.toJson());

class TransferCoinModel {
  final String? result;
  final int? statusCode;

  TransferCoinModel({
    this.result,
    this.statusCode,
  });

  factory TransferCoinModel.fromJson(Map<String, dynamic> json) => TransferCoinModel(
    result: json["result"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "statusCode": statusCode,
  };
}