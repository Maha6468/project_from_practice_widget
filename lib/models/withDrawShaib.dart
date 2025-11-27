// To parse this JSON data, do
//
//     final withDrawShib = withDrawShibFromJson(jsonString);

import 'dart:convert';

WithDrawShib withDrawShibFromJson(String str) => WithDrawShib.fromJson(json.decode(str));

String withDrawShibToJson(WithDrawShib data) => json.encode(data.toJson());

class WithDrawShib {
  final String? errorMessage;
  final int? statusCode;

  WithDrawShib({
    this.errorMessage,
    this.statusCode,
  });

  factory WithDrawShib.fromJson(Map<String, dynamic> json) => WithDrawShib(
    errorMessage: json["ErrorMessage"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "ErrorMessage": errorMessage,
    "statusCode": statusCode,
  };
}