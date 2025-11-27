import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:project_from_practice_widget/utility/remote_config_service.dart';
import 'package:store_checker/store_checker.dart';

import '../models/check_app_status_model.dart';

class VersionChecker {
  static const MethodChannel methodChannel = MethodChannel('app/version');

  /// Fetch the installed version code of the app.
  static Future<int> getInstalledVersionCode() async {
    try {
      final code = await methodChannel.invokeMethod<String>('getVersionCode');
      if(code != null) {
        return int.parse(code);
      }
      return 0;
    } catch (e) {
      print("Error getting version code: $e");
      return 0;
    }
  }

  /// Fetch the installed version of the app.
  static Future<String> getInstalledVersionName() async {
    try {
      final version = await methodChannel.invokeMethod('getVersionName');
      return version;
    } catch (e) {
      print("Error getting installed version: $e");
      return "0.0";
    }
  }

  /// Fetch the latest version from the Play Store (Android).
  static Future<double> fetchFromPlayStore() async {
    try {
      final url = Uri.parse('https://api.apkpure.com/v1/apps/com.orbaic.miner/versions');
      final response = await http.get(url, headers: {
        'User-Agent': 'Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.93 Mobile Safari/537.36'
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("fetchFromPlayStore: API Response: $data"); // Debugging

        if (data is Map && data.containsKey('latest_version')) {
          final version = data['latest_version'];
          return double.tryParse(version.toString()) ?? 0.0;
        } else {
          throw Exception("fetchFromPlayStore: Unexpected response format");
        }
      } else {
        throw Exception("fetchFromPlayStore: Failed to fetch version from API, Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("fetchFromPlayStore: Error fetching version from API: $e");
      return 0.0;
    }
  }

  /// Fetch the latest version from the App Store (iOS).
  static Future<String> fetchFromAppStore() async {
    try {
      final response = await http.get(
        Uri.parse('https://itunes.apple.com/lookup?id=6503300642&t=${DateTime.now().millisecondsSinceEpoch}'),
        headers: {
          'Cache-Control': 'no-cache, no-store, must-revalidate',
          'Pragma': 'no-cache',
          'Expires': '0',
        },
      );
      // 'https://itunes.apple.com/lookup?bundleId=com.orbaic.miner'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Extracting the version name (string format)
        return data['results'][0]['version'] ?? '0.0';
      } else {
        throw Exception("Failed to fetch version from App Store");
      }
    } catch (e) {
      print("Error fetching version from App Store: $e");
      return '0.0'; // default version if error occurs
    }
  }

  static Future<bool> isMiningEnabled(CheckAppStatusResponseModel appStatus) async {
    await RemoteConfigService.initialize();
    final installedCode = await getInstalledVersionCode();

    // 1. Check appStatus blacklist based on api response
    String? blacklistString;
    if (Platform.isAndroid) {
      final Source installationSource = await StoreChecker.getSource;
      print("isMiningEnabled1122: installationSource: $installationSource");
      print("isMiningEnabled1122: miningBlacklistAndroid: ${appStatus.result?.miningBlacklistAndroid}");

      switch (installationSource) {
        case Source.IS_INSTALLED_FROM_PLAY_STORE:
          blacklistString = appStatus.result?.miningBlacklistAndroid;
          break;
        case Source.IS_INSTALLED_FROM_HUAWEI_APP_GALLERY:
          blacklistString = appStatus.result?.miningBlacklistHuawei;
          break;
        default:
          blacklistString = appStatus.result?.miningBlacklistAndroid;
      }
    } else if (Platform.isIOS) {
      blacklistString = appStatus.result?.miningBlacklistIOS;
    } else {
      blacklistString = appStatus.result?.miningBlacklistHuawei;
    }

    print("isMiningEnabled1122: blacklistString: $blacklistString");

    if (blacklistString != null && blacklistString.trim().isNotEmpty) {
      final blockedCodes = blacklistString
          .split(',')
          .map((s) => int.tryParse(s.trim()))
          .whereType<int>()
          .toList();
      print('Blocked Codes from API: $blockedCodes');
      return !blockedCodes.contains(installedCode);
    }

    // 2. Check appStatus blacklist based on firebase remote config
    try {
      await RemoteConfigService.initialize();
      if (RemoteConfigService.isBlocklistActive) {
        final blockedCodes = RemoteConfigService.blockedVersionCodes;
        print('Blocked Codes from Remote Config: $blockedCodes');
        return !blockedCodes.contains(installedCode);
      }
    } catch (e) {
      print('RemoteConfig fetch failed: $e');
      // Continue fallback
    }

    return true;

/*    // 3. Fallback to store version check
    if (Platform.isAndroid) {
      final latestVersionCode = await fetchFromPlayStore();
      print("Installed Code: $installedCode | Play Store Latest: $latestVersionCode");
      return installedCode <= latestVersionCode;
    } else {
      final installedVersionName = await getInstalledVersionName();
      final latestVersionName = await fetchFromAppStore();
      print("Installed Version: $installedVersionName | App Store Latest: $latestVersionName");
      return _compareVersionNames(installedVersionName, latestVersionName);
    }*/
  }

  static Future<bool> isWithdrawEnabled() async {
    await RemoteConfigService.initialize();
    if(Platform.isAndroid) {
      return RemoteConfigService.isWithdrawEnabledAndroid;
    } else {
      return true;
    }
  }

  static bool _compareVersionNames(
      String installedVersion, String latestVersion) {
    // Remove dots from the version strings and convert them to integers
    int installedVersionInt = int.parse(installedVersion.replaceAll('.', ''));
    int latestVersionInt = int.parse(latestVersion.replaceAll('.', ''));

    print(
        "isDynamicMiningEnabled: Installed Version (int): $installedVersionInt");
    print("isDynamicMiningEnabled: fetch From AppStore (int): $latestVersionInt");

    // Compare the integer values
    return installedVersionInt <= latestVersionInt;
  }
}