// To parse this JSON data, do
//
//     final teamModel = teamModelFromJson(jsonString);

import 'dart:convert';

TeamModel teamModelFromJson(String str) => TeamModel.fromJson(json.decode(str));

String teamModelToJson(TeamModel data) => json.encode(data.toJson());

class TeamModel {
  final Result? result;
  final int? statusCode;

  TeamModel({
    this.result,
    this.statusCode,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
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
  final double? totalReferralMiningBonusEarned;
  final double? totalReferralEarned;
  final TeamMember? teamMember;
  final bool? hasReferredBy;

  Result({
    this.referralCode,
    this.totalReferralMiningBonusEarned,
    this.totalReferralEarned,
    this.teamMember,
    this.hasReferredBy
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    referralCode: json["ReferralCode"],
    totalReferralMiningBonusEarned: json["TotalReferralMiningBonusEarned"],
    totalReferralEarned: json["TotalReferralEarned"],
    hasReferredBy: json["HasReferredBy"],
    teamMember: json["TeamMember"] == null ? null : TeamMember.fromJson(json["TeamMember"]),
  );

  Map<String, dynamic> toJson() => {
    "ReferralCode": referralCode,
    "TotalReferralMiningBonusEarned": totalReferralMiningBonusEarned,
    "TotalReferralEarned": totalReferralEarned,
    "HasReferredBy": hasReferredBy,
    "TeamMember": teamMember?.toJson(),
  };
}

class TeamMember {
  final Team? team;

  TeamMember({
    this.team,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) => TeamMember(
    team: json["Team"] == null ? null : Team.fromJson(json["Team"]),
  );

  Map<String, dynamic> toJson() => {
    "Team": team?.toJson(),
  };
}

class Team {
  final List<TeamMemberElement>? teamMembers;

  Team({
    this.teamMembers,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    teamMembers: json["teamMembers"] == null ? [] : List<TeamMemberElement>.from(json["teamMembers"]!.map((x) => TeamMemberElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "teamMembers": teamMembers == null ? [] : List<dynamic>.from(teamMembers!.map((x) => x.toJson())),
  };
}

class TeamMemberElement {
  final String? fullname;
  final bool? isMining;

  TeamMemberElement({
    this.fullname,
    this.isMining,
  });

  factory TeamMemberElement.fromJson(Map<String, dynamic> json) => TeamMemberElement(
    fullname: json["fullname"],
    isMining: json["isMining"],
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "isMining": isMining,
  };
}