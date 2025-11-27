// To parse this JSON data, do
//
//     final pingAllUsers = pingAllUsersFromJson(jsonString);

import 'dart:convert';

PingAllUsers pingAllUsersFromJson(String str) => PingAllUsers.fromJson(json.decode(str));

String pingAllUsersToJson(PingAllUsers data) => json.encode(data.toJson());

class PingAllUsers {
  final String? result;
  final int? statusCode;

  PingAllUsers({
    this.result,
    this.statusCode,
  });

  factory PingAllUsers.fromJson(Map<String, dynamic> json) => PingAllUsers(
    result: json["result"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "statusCode": statusCode,
  };
}