import 'dart:convert';

WalletTokenModel walletTokenResponseModelFromJson(String str) => WalletTokenModel.fromJson(json.decode(str));



class WalletTokenModel {
  Result? result;
  int? statusCode;

  WalletTokenModel({this.result, this.statusCode});

  WalletTokenModel.fromJson(Map<String, dynamic> json) {
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
  double? totalAciTokens;
  double? referralMineBonusTokens;
  double? aciTokens;
  double? minedTokens;
  double? referralTokens;
  double? totalMineAndQuize;
  double? rewardTokens;
  double? stackedTokens;
  double? totalRefAndBoost;
  double? quizRewardTokens;
  double? merchantToken;
  double? extraReward;
  bool? isMerchant;
  List<Offers>? offers;
  Result(
      {this.totalAciTokens,
        this.referralMineBonusTokens,
        this.aciTokens,
        this.minedTokens,
        this.referralTokens,
        this.totalMineAndQuize,
        this.rewardTokens,
        this.stackedTokens,
        this.totalRefAndBoost,
        this.quizRewardTokens,
        this.merchantToken,
        this.extraReward,
        this.isMerchant,
        this.offers,
      });

  Result.fromJson(Map<String, dynamic> json) {
    totalAciTokens = json['totalAciTokens'];
    referralMineBonusTokens = json['referralMineBonusTokens'];
    aciTokens = json['aciTokens'];
    minedTokens = json['minedTokens'];
    referralTokens = json['referralTokens'];
    totalMineAndQuize = json['totalMineAndQuize'];
    rewardTokens = json['rewardTokens'];
    stackedTokens = json['stackedTokens'];
    totalRefAndBoost = json['totalRefAndBoost'];
    quizRewardTokens = json['quizRewardTokens'];
    merchantToken = json['merchantToken'];
    extraReward = json['extraReward'];
    isMerchant = json['isMerchant'];
    offers = json["offers"] == null ? null : (json["offers"] as List).map((e) => Offers.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalAciTokens'] = this.totalAciTokens;
    data['referralMineBonusTokens'] = this.referralMineBonusTokens;
    data['aciTokens'] = this.aciTokens;
    data['minedTokens'] = this.minedTokens;
    data['referralTokens'] = this.referralTokens;
    data['totalMineAndQuize'] = this.totalMineAndQuize;
    data['rewardTokens'] = this.rewardTokens;
    data['stackedTokens'] = this.stackedTokens;
    data['totalRefAndBoost'] = this.totalRefAndBoost;
    data['quizRewardTokens'] = this.quizRewardTokens;
    data['merchantToken'] = this.merchantToken;
    data['extraReward'] = this.extraReward;
    data['isMerchant'] = this.isMerchant;
    if(offers != null) {
      data["offers"] = offers?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}


class Offers {
  String? id;
  String? userId;
  double? token;
  String? type;
  String? description;
  bool? merchant;
  int? createdAt;
  int? expireAt;
  bool? claim;

  Offers({this.id, this.userId, this.token, this.type, this.description, this.merchant, this.createdAt, this.expireAt, this.claim});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["userId"];
    token = json["token"];
    type = json["type"];
    description = json["description"];
    merchant = json["merchant"];
    createdAt = json["createdAt"];
    expireAt = json["expireAt"];
    claim = json["claim"];
  }

  static List<Offers> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Offers.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["userId"] = userId;
    _data["token"] = token;
    _data["type"] = type;
    _data["description"] = description;
    _data["merchant"] = merchant;
    _data["createdAt"] = createdAt;
    _data["expireAt"] = expireAt;
    _data["claim"] = claim;
    return _data;
  }
}
