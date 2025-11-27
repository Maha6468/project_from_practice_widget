import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  static Future<void> initialize() async {
    // Initialize Firebase first
    await Firebase.initializeApp();

    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));
    await _remoteConfig.fetchAndActivate();
  }

  /// Get list of blocked version codes
  static List<int> get blockedVersionCodes {
    var codesString = "";
    if(Platform.isAndroid) {
      codesString = _remoteConfig.getString('mining_ad_blacklist_android');
    } else {
      codesString = _remoteConfig.getString('mining_ad_blacklist');
    }

    return codesString.split(',')
        .map((s) => int.tryParse(s.trim()))
        .whereType<int>()
        .toList();
  }

  static bool get isBlocklistActive =>
      Platform.isAndroid
          ? _remoteConfig.getBool('enable_version_blacklist_android')
          : _remoteConfig.getBool('enable_version_blacklist');


  static bool get isWithdrawEnabledAndroid =>
      _remoteConfig.getBool('enable_withdraw_android');

}