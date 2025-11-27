
class StackHistoryModel {
  String? id;
  String? userId;
  double? aciTokensInStack;
  int? durationInYears;
  int? createdAt;
  int? expireDuration;
  double? profit;
  bool? claimable;
  StackDetails? stackDetails;
  String? stackType;

  StackHistoryModel({this.id, this.userId, this.aciTokensInStack, this.durationInYears, this.createdAt, this.expireDuration, this.profit, this.claimable, this.stackDetails, this.stackType});

  StackHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["userId"];
    aciTokensInStack = json["aciTokensInStack"];
    durationInYears = json["durationInYears"];
    createdAt = json["createdAt"];
    expireDuration = json["expireDuration"];
    profit = json["profit"];
    claimable = json["claimable"];
    stackDetails = json["stackDetails"] == null ? null : StackDetails.fromJson(json["stackDetails"]);
    stackType = json["stackType"];
  }

  static List<StackHistoryModel> fromList(List<dynamic> list) {
    return list.map((map) => StackHistoryModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["userId"] = userId;
    _data["aciTokensInStack"] = aciTokensInStack;
    _data["durationInYears"] = durationInYears;
    _data["createdAt"] = createdAt;
    _data["expireDuration"] = expireDuration;
    _data["profit"] = profit;
    _data["claimable"] = claimable;
    if(stackDetails != null) {
      _data["stackDetails"] = stackDetails?.toJson();
    }
    _data["stackType"] = stackType;
    return _data;
  }
}

class StackDetails {
  double? referralTotalStackToken;
  double? referralMineBonusTokensStack;
  String? type;
  double? referralTokensStack;

  StackDetails({this.referralTotalStackToken, this.referralMineBonusTokensStack, this.type, this.referralTokensStack});

  StackDetails.fromJson(Map<String, dynamic> json) {
    referralTotalStackToken = json["referralTotalStackToken"];
    referralMineBonusTokensStack = json["referralMineBonusTokensStack"];
    type = json["type"];
    referralTokensStack = json["referralTokensStack"];
  }

  static List<StackDetails> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => StackDetails.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["referralTotalStackToken"] = referralTotalStackToken;
    _data["referralMineBonusTokensStack"] = referralMineBonusTokensStack;
    _data["type"] = type;
    _data["referralTokensStack"] = referralTokensStack;
    return _data;
  }
}