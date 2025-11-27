// To parse this JSON data, do
//
//     final allTeamModel = allTeamModelFromJson(jsonString);

import 'dart:convert';

AllTeamModel allTeamModelFromJson(String str) => AllTeamModel.fromJson(json.decode(str));

String allTeamModelToJson(AllTeamModel data) => json.encode(data.toJson());

class AllTeamModel {
  final Result? result;
  final int? statusCode;

  AllTeamModel({
    this.result,
    this.statusCode,
  });

  factory AllTeamModel.fromJson(Map<String, dynamic> json) => AllTeamModel(
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result?.toJson(),
    "statusCode": statusCode,
  };
}

class Result {
  final List<TeamMember>? teamMembers;

  Result({
    this.teamMembers,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    teamMembers: json["teamMembers"] == null ? [] : List<TeamMember>.from(json["teamMembers"]!.map((x) => TeamMember.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "teamMembers": teamMembers == null ? [] : List<dynamic>.from(teamMembers!.map((x) => x.toJson())),
  };
}

class TeamMember {
  final String? fullname;
  final bool? isMining;

  TeamMember({
    this.fullname,
    this.isMining,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) => TeamMember(
    fullname: json["fullName"],
    isMining: json["isMining"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullname,
    "isMining": isMining,
  };
}