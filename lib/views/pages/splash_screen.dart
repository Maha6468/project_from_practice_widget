import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import 'package:store_checker/store_checker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../colors/app_colors.dart';
import '../../common/app_loading.dart';
import '../../common/global_widget.dart';

import '../../common/perfrance.dart';
import '../../controllers/splash_controller.dart';
import '../../data/repo/repo.dart';
import '../../models/check_app_status_model.dart';
import '../../utility/version_checker.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController controller = Get.put(SplashController());

  final MethodChannel methodChannel = MethodChannel('app/version');

  @override
  void initState() {
    super.initState();
    print("Stacking123: splash");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAppStatus(context, methodChannel, (isForceLogout) async {
        print("isForceLogout: isForceLogout: $isForceLogout");
        Get.back();
        controller.progressBarVisibility.value = true;
        String token = await controller.getToken();
        await controller.startProgress(token, isForceLogout);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Container(
                height: Get.height,
              ),
              const Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/app_logo_big.png'),
                        height: 100,
                        width: 100,
                      ),
                      Image(
                        image:
                        AssetImage('assets/images/orbaic_text_image.png'),
                        height: 100,
                        width: 300,
                      ),
                      Visibility(
                        visible: true, // You can toggle this based on your controller state
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void checkAppStatus(BuildContext context, MethodChannel channel, Function callback) async {
  try {
    print('Check App Status Called');
    showLoading();

    final response = await UserRepo.getInstance().checkAppStatus();
    response.fold(
          (error) {
        print('Check App Status error: ${error.toString()}');
        errorSnack(error.toString());
        hideLoading();
        callback(false);
      },
          (r) async {
        hideLoading();
        CheckAppStatusResponseModel appStatus = r;

        // Save withdraw flag
        bool isWithdrawEnabled = await VersionChecker.isWithdrawEnabled();
        PreferenceHelper.instance.setData(Pref.isWithdrawEnabled, isWithdrawEnabled);

        // Mining flag logic
        bool wasMiningEnabled = await PreferenceHelper.instance.getData(Pref.miningEnabledStatus) ?? true;
        bool isDynamicMiningEnabled = await VersionChecker.isMiningEnabled(appStatus);
        PreferenceHelper.instance.setData(Pref.miningEnabledStatus, isDynamicMiningEnabled);

        if(Platform.isIOS) {
          if (!wasMiningEnabled && wasMiningEnabled != isDynamicMiningEnabled) {
            callback(true); // mining just became enabled
          }
        }

        PreferenceHelper.instance.setData(Pref.isAdEnabled, isDynamicMiningEnabled);


        final version = await channel.invokeMethod('getVersionCode');
        double minSupportedVersionCode = 0.0;
        bool? maintenanceMode;
        bool? updateRequired;
        bool? noticeMode;
        String? maintenanceMessage;
        String? updateMessage;
        String? noticeMessage;

        double myVersion = double.tryParse(version.toString()) ?? 0.0;

        if (Platform.isAndroid) {
          final Source installationSource = await StoreChecker.getSource;
          print("installationSource: $installationSource");

          switch (installationSource) {
            case Source.IS_INSTALLED_FROM_PLAY_STORE:
              minSupportedVersionCode = double.tryParse(appStatus.result?.minSupportedVersionCodeAndroid ?? '') ?? 0.0;
              maintenanceMode = appStatus.result?.maintenanceModeAndroid;
              updateRequired = appStatus.result?.updateRequiredAndroid;
              noticeMode = appStatus.result?.noticeModeAndroid;
              maintenanceMessage = appStatus.result?.maintenanceMessageAndroid;
              updateMessage = appStatus.result?.updateMessageAndroid;
              noticeMessage = appStatus.result?.noticeMessageAndroid;
              break;
            case Source.IS_INSTALLED_FROM_HUAWEI_APP_GALLERY:
              minSupportedVersionCode = double.tryParse(appStatus.result?.minSupportedVersionCodeHuawei ?? '') ?? 0.0;
              maintenanceMode = appStatus.result?.maintenanceModeHuawei;
              updateRequired = appStatus.result?.updateRequiredHuawei;
              noticeMode = appStatus.result?.noticeModeHuawei;
              maintenanceMessage = appStatus.result?.maintenanceMessageHuawei;
              updateMessage = appStatus.result?.updateMessageHuawei;
              noticeMessage = appStatus.result?.noticeMessageHuawei;
              break;
            default:
              minSupportedVersionCode = double.tryParse(appStatus.result?.minSupportedVersionCodeAndroid ?? '') ?? 0.0;
              maintenanceMode = appStatus.result?.maintenanceModeAndroid;
              updateRequired = appStatus.result?.updateRequiredAndroid;
              noticeMode = appStatus.result?.noticeModeAndroid;
              maintenanceMessage = appStatus.result?.maintenanceMessageAndroid;
              updateMessage = appStatus.result?.updateMessageAndroid;
              noticeMessage = appStatus.result?.noticeMessageAndroid;
          }

        } else if (Platform.isIOS) {
          minSupportedVersionCode = double.tryParse(appStatus.result?.minSupportedVersionCodeIos ?? '') ?? 0.0;
          maintenanceMode = appStatus.result?.maintenanceModeIos;
          updateRequired = appStatus.result?.updateRequiredIos;
          noticeMode = appStatus.result?.noticeModeIos;
          maintenanceMessage = appStatus.result?.maintenanceMessageIos;
          updateMessage = appStatus.result?.updateMessageIos;
          noticeMessage = appStatus.result?.noticeMessageIos;
        }


        // Decide what to show
        if (maintenanceMode == true) {
          String message = (maintenanceMessage?.isNotEmpty ?? false)
              ? maintenanceMessage!
              : "Please wait a while. We will be back soon.";
          showMaintenanceDialog(context, message);
        } else if (updateRequired == true  && myVersion < minSupportedVersionCode) {
          String message = (updateMessage?.isNotEmpty ?? false)
              ? updateMessage!
              : "Please click on update button. It will redirect you to play store to do update.";
          showUpdateDialog(context, message);
        } else if (noticeMode == true) {
          String message = noticeMessage ?? "";
          showNoticeDialog(context, message, callback);
        } else {
          print('Check App Status: continue');
          callback(false);
        }
      },
    );
  } catch (e) {
    print('Check App Status Exception: $e');
    errorSnack("$e");
    PreferenceHelper.instance.setData(Pref.miningEnabledStatus, true);
    hideLoading();
    callback(false);
  }
}


//maha
extension on Function() {
  void setData(String isWithdrawEnabled, bool isWithdrawEnabled2) {}

  Future getData(String miningEnabledStatus) async {}
}


/*void checkAppStatus(BuildContext context, MethodChannel channel, Function callback) async {
  try {
    print('Check App Status Called');
    showLoading();

    // Make API call to check app status
    final response = await UserRepo.getInstance().checkAppStatus();
    response.fold(
          (error) {
        // Handle error response
        print('Check App Status error: ${error.toString()}');
        errorSnack(error.toString());
        hideLoading();
        callback(false);
      },
          (r) async {
        hideLoading();
        CheckAppStatusResponseModel appStatus = r;

        bool isWithdrawEnabled = await VersionChecker.isWithdrawEnabled();
        print("isWithdrawEnabled: $isWithdrawEnabled");
        PreferenceHelper.instance.setData(Pref.isWithdrawEnabled, isWithdrawEnabled);

        bool wasMiningEnabled = await PreferenceHelper.instance.getData(Pref.miningEnabledStatus) ?? true;
        print("isForceLogout: wasMiningEnabled: $wasMiningEnabled");
        bool isDynamicMiningEnabled = await VersionChecker.isMiningEnabled(appStatus);
        print("isDynamicMiningEnabled: $isDynamicMiningEnabled");
        PreferenceHelper.instance.setData(Pref.miningEnabledStatus, isDynamicMiningEnabled);
        print("isForceLogout: isDynamicMiningEnabled: $isDynamicMiningEnabled");

        if(wasMiningEnabled == false && wasMiningEnabled != isDynamicMiningEnabled) {
          print("isForceLogout: callback: true");
          callback(true);
        }

        PreferenceHelper.instance.setData(Pref.isAdEnabled, isDynamicMiningEnabled);

        final Future versionFuture = channel.invokeMethod('getVersionCode');
        versionFuture.then((version) {
          double minSupportedVersionCode = 0.0;
          if (Platform.isAndroid) {
            minSupportedVersionCode = double.tryParse(appStatus.result?.minSupportedVersionCodeAndroid ?? '') ?? 0.0;
          } else {
            minSupportedVersionCode = double.tryParse(appStatus.result?.minSupportedVersionCodeIos ?? '') ?? 0.0;
          }

          double myVersion = double.parse(version);
          print("Check App Status myVersion: $myVersion");
          print("Check App Status minSupportedVersionCode: $minSupportedVersionCode");
          if (myVersion < minSupportedVersionCode) {
            appStatus.result?.updateRequired = true;
          } else {
            appStatus.result?.updateRequired = false;
          }

          print(
              'Check App Status response maintenanceMode: ${appStatus.result?.maintenanceMode}');
          print(
              'Check App Status response updateRequired: ${appStatus.result?.updateRequired}');
          print(
              'Check App Status response noticeMode: ${appStatus.result?.noticeMode}');
          if (appStatus.result?.maintenanceMode == true) {
            var message = "Please wait a while. We will be back soon";
            if (appStatus.result?.maintenanceMessage?.isNotEmpty ?? false) {
              message = appStatus.result?.maintenanceMessage ?? "";
            }
            showMaintenanceDialog(context, message);
          } else if (appStatus.result?.updateRequired == true) {
            var message =
                "Please click on update button. It will redirect you to play store to do update.";
            if (appStatus.result?.updateMessage?.isNotEmpty ?? false) {
              message = appStatus.result?.updateMessage ?? "";
            }
            showUpdateDialog(context, message);
            print('Check App Status updateRequired');
          } else if (appStatus.result?.noticeMode == true) {
            print('Check App Status notice');
            var message = appStatus.result?.noticeMessage ?? "";
            print('Check App Status notice message: $message');
            showNoticeDialog(context, message, callback);
          } else {
            // Continue to the next screen or action
            print('Check App Status continue');
            hideLoading();
            callback(false);
          }

          // errorSnack(version);
        }).catchError((error) {
          print("Error occurred while getting version: $error");
        });
      },
    );
  } catch (e) {
    print('Check App Status Exception: $e');
    errorSnack("$e");
    hideLoading();
    callback(false);
  }
}*/

void showUpdateDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissal by clicking outside or pressing back
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false, // Prevent dialog dismissal when back button is pressed
        child: AlertDialog(
          title: const Text("Update Required"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                const String androidUrl =
                    'https://play.google.com/store/apps/details?id=com.orbaic.miner';
                const String iosUrl =
                    'https://apps.apple.com/us/app/orbaic/id6503300642';

                final url = Platform.isAndroid ? androidUrl : iosUrl;

                // Launch the appropriate URL
                launchUrl(Uri.parse(url));
              },
              child: const Text("Update Now"),
            ),
          ],
        ),
      );
    },
  );
}

void showMaintenanceDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    // Set this to true to allow the dialog to be dismissed by clicking outside of it or by pressing the back button
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        // Prevent dialog from being dismissed when back button is pressed
        child: AlertDialog(
          title: const Text("Under Maintenance"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
                // Close the app
                SystemNavigator.pop();
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    },
  );
}

void showNoticeDialog(BuildContext context, String message, Function callback) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: null,
          content: SingleChildScrollView(
            child: HtmlWidget(message),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                callback();
              },
              child: const Text("Ok, got it"),
            ),
          ],
        ),
      );
    },
  );
}


