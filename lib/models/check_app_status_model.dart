import 'dart:convert';

CheckAppStatusResponseModel checkAppStatusResponseModelFromJson(String str) =>
    CheckAppStatusResponseModel.fromJson(json.decode(str));

String checkAppStatusResponseModelToJson(CheckAppStatusResponseModel data) =>
    json.encode(data.toJson());

class CheckAppStatusResponseModel {
  Result? result;
  int? statusCode;

  CheckAppStatusResponseModel({this.result, this.statusCode});

  factory CheckAppStatusResponseModel.fromJson(Map<String, dynamic> json) =>
      CheckAppStatusResponseModel(
        result: json['result'] == null ? null : Result.fromJson(json['result']),
        statusCode: json['statusCode'],
      );

  Map<String, dynamic> toJson() => {
    'result': result?.toJson(),
    'statusCode': statusCode,
  };
}

class Result {
  String? id;
  double? versionAndroid;
  double? versionIos;
  double? versionHuawei;
  bool? maintenanceModeAndroid;
  bool? maintenanceModeIos;
  bool? maintenanceModeHuawei;
  bool? updateRequiredAndroid;
  bool? updateRequiredIos;
  bool? updateRequiredHuawei;
  String? updateMessageAndroid;
  String? updateMessageIos;
  String? updateMessageHuawei;
  String? minSupportedVersionCodeAndroid;
  String? minSupportedVersionCodeIos;
  String? minSupportedVersionCodeHuawei;
  String? maintenanceMessageAndroid;
  String? maintenanceMessageIos;
  String? maintenanceMessageHuawei;
  bool? noticeModeAndroid;
  bool? noticeModeIos;
  bool? noticeModeHuawei;
  String? noticeMessageAndroid;
  String? noticeMessageIos;
  String? noticeMessageHuawei;
  bool? miningEnabledAndroid;
  bool? miningEnabledIos;
  bool? miningEnabledHuawei;
  bool? adEnabledAndroid;
  bool? adEnabledIOS;
  bool? adEnabledHuawei;
  String? miningBlacklistAndroid;
  String? miningBlacklistIOS;
  String? miningBlacklistHuawei;
  String? adBlacklistAndroid;
  String? adBlacklistIOS;
  String? adBlacklistHuawei;

  Result({
    this.id,
    this.versionAndroid,
    this.versionIos,
    this.versionHuawei,
    this.maintenanceModeAndroid,
    this.maintenanceModeIos,
    this.maintenanceModeHuawei,
    this.updateRequiredAndroid,
    this.updateRequiredIos,
    this.updateRequiredHuawei,
    this.updateMessageAndroid,
    this.updateMessageIos,
    this.updateMessageHuawei,
    this.minSupportedVersionCodeAndroid,
    this.minSupportedVersionCodeIos,
    this.minSupportedVersionCodeHuawei,
    this.maintenanceMessageAndroid,
    this.maintenanceMessageIos,
    this.maintenanceMessageHuawei,
    this.noticeModeAndroid,
    this.noticeModeIos,
    this.noticeModeHuawei,
    this.noticeMessageAndroid,
    this.noticeMessageIos,
    this.noticeMessageHuawei,
    this.miningEnabledAndroid,
    this.miningEnabledIos,
    this.miningEnabledHuawei,
    this.adEnabledAndroid,
    this.adEnabledIOS,
    this.adEnabledHuawei,
    this.miningBlacklistAndroid,
    this.miningBlacklistIOS,
    this.miningBlacklistHuawei,
    this.adBlacklistAndroid,
    this.adBlacklistIOS,
    this.adBlacklistHuawei,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json['id'],
    versionAndroid: json['versionAndroid']?.toDouble(),
    versionIos: json['versionIos']?.toDouble(),
    versionHuawei: json['versionHuawei']?.toDouble(),
    maintenanceModeAndroid: json['maintenanceModeAndroid'],
    maintenanceModeIos: json['maintenanceModeIos'],
    maintenanceModeHuawei: json['maintenanceModeHuawei'],
    updateRequiredAndroid: json['updateRequiredAndroid'],
    updateRequiredIos: json['updateRequiredIos'],
    updateRequiredHuawei: json['updateRequiredHuawei'],
    updateMessageAndroid: json['updateMessageAndroid'],
    updateMessageIos: json['updateMessageIos'],
    updateMessageHuawei: json['updateMessageHuawei'],
    minSupportedVersionCodeAndroid: _toString(json['minSupportedVersionCodeAndroid']),
    minSupportedVersionCodeIos: _toString(json['minSupportedVersionCodeIos']),
    minSupportedVersionCodeHuawei: _toString(json['minSupportedVersionCodeHuawei']),
    maintenanceMessageAndroid: json['maintenanceMessageAndroid'],
    maintenanceMessageIos: json['maintenanceMessageIos'],
    maintenanceMessageHuawei: json['maintenanceMessageHuawei'],
    noticeModeAndroid: json['noticeModeAndroid'],
    noticeModeIos: json['noticeModeIos'],
    noticeModeHuawei: json['noticeModeHuawei'],
    noticeMessageAndroid: json['noticeMessageAndroid'],
    noticeMessageIos: json['noticeMessageIos'],
    noticeMessageHuawei: json['noticeMessageHuawei'],
    miningEnabledAndroid: json['miningEnabledAndroid'],
    miningEnabledIos: json['miningEnabledIos'],
    miningEnabledHuawei: json['miningEnabledHuawei'],
    adEnabledAndroid: json['adEnabled_android'],
    adEnabledIOS: json['adEnabled_iOS'],
    adEnabledHuawei: json['adEnabled_Huawei'],
    miningBlacklistAndroid: _toString(json['mining_blacklist_android']),
    miningBlacklistIOS: json['mining_blacklist_iOS'],
    miningBlacklistHuawei: json['mining_blacklist_Huawei'],
    adBlacklistAndroid: json['ad_blacklist_android'],
    adBlacklistIOS: json['ad_blacklist_iOS'],
    adBlacklistHuawei: json['ad_blacklist_Huawei'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'versionAndroid': versionAndroid,
    'versionIos': versionIos,
    'versionHuawei': versionHuawei,
    'maintenanceModeAndroid': maintenanceModeAndroid,
    'maintenanceModeIos': maintenanceModeIos,
    'maintenanceModeHuawei': maintenanceModeHuawei,
    'updateRequiredAndroid': updateRequiredAndroid,
    'updateRequiredIos': updateRequiredIos,
    'updateRequiredHuawei': updateRequiredHuawei,
    'updateMessageAndroid': updateMessageAndroid,
    'updateMessageIos': updateMessageIos,
    'updateMessageHuawei': updateMessageHuawei,
    'minSupportedVersionCodeAndroid': minSupportedVersionCodeAndroid,
    'minSupportedVersionCodeIos': minSupportedVersionCodeIos,
    'minSupportedVersionCodeHuawei': minSupportedVersionCodeHuawei,
    'maintenanceMessageAndroid': maintenanceMessageAndroid,
    'maintenanceMessageIos': maintenanceMessageIos,
    'maintenanceMessageHuawei': maintenanceMessageHuawei,
    'noticeModeAndroid': noticeModeAndroid,
    'noticeModeIos': noticeModeIos,
    'noticeModeHuawei': noticeModeHuawei,
    'noticeMessageAndroid': noticeMessageAndroid,
    'noticeMessageIos': noticeMessageIos,
    'noticeMessageHuawei': noticeMessageHuawei,
    'miningEnabledAndroid': miningEnabledAndroid,
    'miningEnabledIos': miningEnabledIos,
    'miningEnabledHuawei': miningEnabledHuawei,
    'adEnabled_android': adEnabledAndroid,
    'adEnabled_iOS': adEnabledIOS,
    'adEnabled_Huawei': adEnabledHuawei,
    'mining_blacklist_android': miningBlacklistAndroid,
    'mining_blacklist_iOS': miningBlacklistIOS,
    'mining_blacklist_Huawei': miningBlacklistHuawei,
    'ad_blacklist_android': adBlacklistAndroid,
    'ad_blacklist_iOS': adBlacklistIOS,
    'ad_blacklist_Huawei': adBlacklistHuawei,
  };

  static String? _toString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }
}