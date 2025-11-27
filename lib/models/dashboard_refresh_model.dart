import 'dart:convert';

DashboardRefreshModel dashboardRefreshModelFromJson(String str) =>
    DashboardRefreshModel.fromJson(json.decode(str));

String dashboardRefreshModelToJson(DashboardRefreshModel data) => json.encode(data.toJson());

class DashboardRefreshModel {
  Result? result;
  int? statusCode;

  DashboardRefreshModel({this.result, this.statusCode});

  DashboardRefreshModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Result {
  double? newHashRate;
  ActiveTeam? activeTeam;
  double? newMinedTokens;

  Result({this.newHashRate, this.activeTeam, this.newMinedTokens});

  Result.fromJson(Map<String, dynamic> json) {
    newHashRate = json['NewHashRate'];
    activeTeam = json['ActiveTeam'] != null
        ? new ActiveTeam.fromJson(json['ActiveTeam'])
        : null;
    newMinedTokens = json['NewMinedTokens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NewHashRate'] = this.newHashRate;
    if (this.activeTeam != null) {
      data['ActiveTeam'] = this.activeTeam!.toJson();
    }
    data['NewMinedTokens'] = this.newMinedTokens;
    return data;
  }
}

class ActiveTeam {
  int? total;
  int? active;

  ActiveTeam({this.total, this.active});

  ActiveTeam.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['active'] = this.active;
    return data;
  }
}