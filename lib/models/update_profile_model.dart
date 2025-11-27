// To parse this JSON data, do
//
//     final updateProfileModel = updateProfileModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) => UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) => json.encode(data.toJson());

class UpdateProfileModel {
  final Result? result;
  final int? statusCode;

  UpdateProfileModel({
    this.result,
    this.statusCode,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result?.toJson(),
    "statusCode": statusCode,
  };
}

class Result {
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? fullname;
  final String? email;

  Result({
    this.phoneNumber,
    this.dateOfBirth,
    this.fullname,
    this.email,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    phoneNumber: json["phoneNumber"],
    dateOfBirth: json["dateOfBirth"],
    fullname: json["fullname"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
    "dateOfBirth": dateOfBirth,
    "fullname": fullname,
    "email": email,
  };
}