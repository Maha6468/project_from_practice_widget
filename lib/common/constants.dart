

import 'package:google_mobile_ads/google_mobile_ads.dart';

String emptyString = '';
class AppConstant {
  static String baseUrl = 'http://193.203.163.177:8080';
}

//==============================================================================
// ** Status Code Constants **
//==============================================================================
class StatusCodeConstants {
  static var none = "none";
  static var error = "error";
  static var success = "success";
  static var authority = "authority";
  static var badRequest = "badRequest";
  static var notFound = "notFound";
  static var statusOk = "statusOk";
  static var unAuthorized = "unAuthorized";
  static var unKnown = "unKnown";
  static InterstitialAd? interstitialAd;
  static var errorCodes = [
    100,
    101,
    102,
    203,
    204,
    205,
    206,
    207,
    300,
    301,
    302,
    303,
    304,
    305,
    306,
    307,
    308,
    401,
    402,
    403,
    405,
    406,
    407,
    408,
    409,
    410,
    411,
    412,
    413,
    414,
    415,
    416,
    417,
    422,
    423,
    424,
    426,
    429,
    431,
    500,
    501,
    502,
    503,
    504,
    505,
    506,
    507
  ];
  static var successCodes = [200, 201, 202, 205];
  static var authorityCodes = [401];
  static var badRequestCodes = [400];
  static var notFoundCode = [404];
  static var statusOkCode = 0;
  static var unAuthorizedCode = 401;
}
