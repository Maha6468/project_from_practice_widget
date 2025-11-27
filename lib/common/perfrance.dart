import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static String token = 'token';
  static String fcmToken = 'fcmToken';
  static String otp = 'otp';
  static String userId = 'user_id';
  static String mobileNo = 'mobile_no';
  static String emailId = 'email_id';
  static String login = 'login';
  static String onBoarding = 'onBoarding';
  static String deviceId = 'deviceId';
  static String deviceType = 'deviceType';
  static String deviceName = 'deviceName';
  static String companyId = 'company_id';
  static String businessId = 'business_id';
  static String cityId = 'city_id';
  static String cityName = 'city_name';
  static String currentTimeLeft = 'current_timer_left';
  static String registrationStatus = 'registration_status';
  static String businessSenderId = 'businessSenderId';

  static String offerData = 'offer_data';

  static String fcmDeviceToken = 'fcm_device_token';
  static String miningEnabledStatus = 'mining_status';
  static String isAdEnabled = 'is_ad_enabled';
  static String isWithdrawEnabled = 'is_withdraw_enabled';
  static String isProfileFaqSeen = 'is_profile_faq_seen';
}

class PreferenceHelper {
  static final PreferenceHelper instance = PreferenceHelper._internal();

  factory PreferenceHelper() {
    return instance;
  }

  PreferenceHelper._internal();

  static SharedPreferences? preferences;

  createSharedPref() {
    SharedPreferences.getInstance().then((pref) {
      PreferenceHelper.preferences = pref;
    });
  }

  setData(String key, dynamic value) {
    if (PreferenceHelper.preferences != null) {
      if (value is String) {
        PreferenceHelper.preferences!.setString(key, value);
      } else if (value is int) {
        PreferenceHelper.preferences!.setInt(key, value);
      } else if (value is double) {
        PreferenceHelper.preferences!.setDouble(key, value);
      } else if (value is bool) {
        PreferenceHelper.preferences!.setBool(key, value);
      } else {
        PreferenceHelper.preferences?.setString(key, value);
      }
    }
  }

  Future<dynamic> getData(String key) async {
    await PreferenceHelper.instance.createSharedPref();
    if (PreferenceHelper.preferences == null) {
      print('sakib preferences null');
      return null;
    } else {
      return PreferenceHelper.preferences!.get(key);
    }
  }

  Future<void> clearData() async {
    if (PreferenceHelper.preferences != null) {
      await SharedPreferences.getInstance().then((value) {
        value.clear();
      });
    }
  }
}