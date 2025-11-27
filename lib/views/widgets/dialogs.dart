import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../ads/AdManager.dart';
import '../../colors/app_colors.dart';
import '../../common/string.dart';
import '../../controllers/home_page_controller.dart';
import '../../routes/app_pages.dart';
import '../navigation_views/home_page.dart';
import '../pages/reset_passsword_page.dart';

enum DialogsAction { yes, cancel }

class Dialogs {
  static Future<DialogsAction> resetPasswordDialog(
      BuildContext context,
      // String title,
      //   String body,
      ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff364156),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          // title: Text(title),
          content: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'difficulty_login'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.16,
                  ),
                ),
                TextSpan(
                  text: 'reset_password'.tr,
                  style: TextStyle(
                    color: Color(0xFF64D2FF),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.16,
                  ),
                ),
                TextSpan(
                  text: 'difficulty_login2'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.16,
                  ),
                ),
                TextSpan(
                  text: 'return_back'.tr,
                  style: TextStyle(
                    color: Color(0xFF6ACB85),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.16,
                  ),
                ),
                TextSpan(
                  text: '".\n\n',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.16,
                  ),
                ),
                TextSpan(
                  text: 'reset_password_recommend'.tr,
                  style: TextStyle(
                    color: Color(0xFF99CC33),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.16,
                  ),
                ),
              ],
            ),
          ),
          icon: Icon(
            Icons.notifications_none_outlined,
            color: Colors.white,
            size: 40,
          ),
          actions: <Widget>[
            InkWell(
              onTap: () => Navigator.of(context).pop(DialogsAction.cancel),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xff6ACC86),
                ),
                child: Text(
                  'return_back'.tr,
                  style: TextStyle(color: Color(0xFFffffff), fontSize: 12),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop(DialogsAction.yes);
                Get.to(() => ResetPasswordPage());
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xff2BA6CE),
                ),
                child: Text(
                  'reset_password'.tr,
                  style: TextStyle(color: Color(0xFFffffff), fontSize: 12),
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> generalDialog(
      BuildContext context,
      // String title,
      String body,
      ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff364156),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          // title: Text(title),
          content: Text(
            body,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              letterSpacing: 1.16,
            ),
          ),
          icon: Icon(
            Icons.notifications_none_outlined,
            color: Colors.white,
            size: 40,
          ),
          actions: <Widget>[
            InkWell(
              onTap: () => Navigator.of(context).pop(DialogsAction.yes),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xff6ACC86),
                ),
                child: Text(
                  'ok'.tr,
                  style: TextStyle(
                    color: Color(0xFFffffff),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> restartAppDialog(
      BuildContext context,
      // String title,
      String body,
      ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff364156),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          // title: Text(title),
          content: Text(
            body,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              letterSpacing: 1.16,
            ),
          ),
          icon: Icon(
            Icons.notifications_none_outlined,
            color: Colors.white,
            size: 40,
          ),
          actions: <Widget>[
            InkWell(
              onTap: () => Navigator.of(context).pop(DialogsAction.yes),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xff6ACC86),
                ),
                child: Text(
                  'ok'.tr,
                  style: TextStyle(
                    color: Color(0xFFffffff),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).pop(DialogsAction.cancel),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xff6ACC86),
                ),
                child: Text(
                  'cancel'.tr,
                  style: TextStyle(
                    color: Color(0xFFffffff),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> orbaicMiningPortalDialog(
      BuildContext context,
      // String title,
      String body,
      ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(); // Close the dialog
        });
        return AlertDialog(
          backgroundColor: Color(0xff364156),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          // title: Text(title),
          content: Text(
            body,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              letterSpacing: 1.16,
            ),
          ),
          icon: Icon(
            Icons.notifications_none_outlined,
            color: Colors.white,
            size: 40,
          ),
          actions: <Widget>[
            // InkWell(
            //   onTap: () => Navigator.of(context).pop(DialogsAction.yes),
            //   child: Container(
            //     padding: EdgeInsets.all(5),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.all(Radius.circular(25)),
            //       color: Color(0xff6ACC86),
            //     ),
            //     child: Text(
            //       'ok'.tr,
            //       style: TextStyle(
            //         color: Color(0xFFffffff),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );

    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> miningNotStartedDialog(
      BuildContext context,
      String body,
      ) async {
    bool hasInternet = await hasInternetConnection();
    bool adBlockerEnabled = await isAdBlockingEnabled();

    String message;

    if (!hasInternet) {
      message =
      "No internet connection detected. Please check your network settings and try again.";
    } else if (adBlockerEnabled) {
      message =
      "An ad blocker is preventing ads from loading. Please disable it to continue.";
    } else if (AdManager.adErrorMessage.isNotEmpty) {
      message = AdManager.adErrorMessage;
    } else {
      message =
      "Oops! Looks like there are no ads available in your area at the moment. You can try again shortly or use a VPN to a different location. No worries — it’s just a temporary hiccup from Google Ads! Thanks for your patience!";
    }

    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.appSecondaryBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          icon: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
            size: 40,
          ),
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              letterSpacing: 1.16,
            ),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pop(DialogsAction.cancel);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: AppColors.appBackgroundColor,
                ),
                child: const Text(
                  'Ok, got it.',
                  style: TextStyle(
                    color: Color(0xFFffffff),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                const url =
                    'https://x.com/Orbaicproject/status/1768102748174876791';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: AppColors.appBackgroundColor,
                ),
                child: Text(
                  'Learn More',
                  style: TextStyle(
                    color: Color(0xFFffffff),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    return action ?? DialogsAction.cancel;
  }

  static Future<DialogsAction> quizAnswerDialog(
      BuildContext context,
      String title,
      String body,
      IconData icon,
      bool isCorrect,
      int answerCount) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Color(0xff364156),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          // title: Text(title),
          content: Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.80),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          icon: Icon(
            //Icons.check_circle_outlined,
            icon,
            color: isCorrect ? Colors.green : Colors.red,
            size: 40,
          ),
          actions: <Widget>[
            InkWell(
              onTap: () => Navigator.of(context).pop(DialogsAction.cancel),
              child: Container(
                width: Get.width / 1.3,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                // margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.appSecondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Center(
                  child: answerCount != 5
                      ? Text(
                    'next_question'.tr,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.59,
                    ),
                  )
                      : Text(
                    'see_result'.tr,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.59,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> quizResultDialog(
      BuildContext context,
      int c,
      int w,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final action = await showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff364156),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          // title: Text(title),
          icon: Image(
            image: AssetImage('assets/images/result_icon.png'),
            height: 150,
          ),
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: Color(0x33FFFFFF))),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'correct'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        c.toString() ?? "0",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Color(0x33FFFFFF),
                    width: 2,
                    height: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'wrong'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        w.toString() ?? "0",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Text(
              'try_after_12_hour'.tr,
              style: TextStyle(
                color: Colors.white.withOpacity(0.80),
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                await prefs.remove('index');
                await prefs.remove('isLeft');
                await prefs.remove(AppString.quizQuestion);
                Navigator.of(Get.context!).pop(DialogsAction.cancel);

                Get.delete<HomePageController>();
                Get.offAllNamed(Routes.MAIN);

                // WidgetsBinding.instance.addPostFrameCallback((_) async {
                //   await controller.getDeshBoardData();
                // });
              },
              child: Container(
                width: Get.width / 1.3,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                // margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.appSecondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Center(
                  child: Text(
                    'ok_got_it'.tr,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.59,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> withLinkDialog(
      BuildContext context,
      String content,
      String link,
      ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff364156),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          // title: Text(title),
          content: Text(
            content,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              letterSpacing: 1.16,
            ),
          ),
          icon: Icon(
            Icons.notifications_none_outlined,
            color: Colors.white,
            size: 40,
          ),
          actions: <Widget>[
            InkWell(
              onTap: () => Navigator.of(context).pop(DialogsAction.cancel),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xff6ACC86),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFFffffff),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                Navigator.of(context).pop(DialogsAction.yes);
                final Uri url = Uri.parse(link);
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $link');
                }
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xff2BA6CE),
                ),
                child: Text(
                  'Open Link',
                  style: TextStyle(
                    color: Color(0xFFffffff),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> leftAppDialog(
      BuildContext context,
      String link,
      ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff364156),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          // title: Text(title),
          content: Text(
            "want_to_leave_the_app".tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              letterSpacing: 1.16,
            ),
          ),
          icon: Icon(
            Icons.notifications_none_outlined,
            color: Colors.white,
            size: 40,
          ),
          actions: <Widget>[
            InkWell(
              onTap: () => Navigator.of(context).pop(DialogsAction.cancel),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xff6ACC86),
                ),
                child: Text(
                  'return_to_app'.tr,
                  style: TextStyle(
                    color: Color(0xFFffffff),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                Navigator.of(context).pop(DialogsAction.yes);
                final Uri url = Uri.parse(link);
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $link');
                }
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xff2BA6CE),
                ),
                child: Text(
                  'leave_app'.tr,
                  style: TextStyle(
                    color: Color(0xFFffffff),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> deleteACDialog(
      BuildContext context,
      ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff364156),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          // title: Text(title),
          content: Text(
            "Are you sure you want to delete your account? If you proceed, your account will be permanently removed from our server, and all tokens will be lost.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              letterSpacing: 1.16,
            ),
          ),
          icon: Icon(
            Icons.notifications_none_outlined,
            color: Colors.white,
            size: 40,
          ),
          actions: <Widget>[
            InkWell(
              onTap: () => Navigator.of(context).pop(DialogsAction.yes),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xff6ACC86),
                ),
                child: Text(
                  ' Yes ',
                  style: TextStyle(
                    color: Color(0xFFffffff),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                Navigator.of(context).pop(DialogsAction.cancel);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xff2BA6CE),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFFffffff),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> deleteConfirmation(
      BuildContext context,
      ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff364156),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          // title: Text(title),
          content: Text(
            "I understand the deletion terms and want to delete my account.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              letterSpacing: 1.16,
            ),
          ),
          icon: Icon(
            Icons.notifications_none_outlined,
            color: Colors.white,
            size: 40,
          ),
          actions: <Widget>[
            InkWell(
              onTap: () => Navigator.of(context).pop(DialogsAction.yes),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xff6ACC86),
                ),
                child: Text(
                  ' Yes process',
                  style: TextStyle(
                    color: Color(0xFFffffff),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                Navigator.of(context).pop(DialogsAction.cancel);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xff2BA6CE),
                ),
                child: Text(
                  'No',
                  style: TextStyle(
                    color: Color(0xFFffffff),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.cancel;
  }

// static Future<DialogsAction> changePasswordDialog(
//     BuildContext context,
//     ) async {
//   final action =
//   return (action != null) ? action : DialogsAction.cancel;
// }
}