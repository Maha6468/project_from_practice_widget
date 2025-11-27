// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final Result? result;
  final int? statusCode;

  ProfileModel({
    this.result,
    this.statusCode,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result?.toJson(),
    "statusCode": statusCode,
  };
}

class Result {
  final String? referralCode;
  final String? phoneNumber;
  final String? fullname;
  final bool? canNotify;
  final String? userid;
  final String? email;

  Result({
    this.referralCode,
    this.phoneNumber,
    this.fullname,
    this.canNotify,
    this.userid,
    this.email,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    referralCode: json["ReferralCode"],
    phoneNumber: json["phoneNumber"],
    fullname: json["fullname"],
    canNotify: json["canNotify"],
    userid: json["userid"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "ReferralCode": referralCode,
    "phoneNumber": phoneNumber,
    "fullname": fullname,
    "canNotify": canNotify,
    "userid": userid,
    "email": email,
  };
}