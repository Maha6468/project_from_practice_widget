import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:project_from_practice_widget/common/string.dart';
import 'package:restart_app/restart_app.dart';

import '../colors/app_colors.dart';
import '../views/widgets/dialogs.dart';

//==============================================================================
// ** Snacks **
//==============================================================================

errorSnack(String error) {
  showSnackBar(
    AppString.error,
    error,
    backgroundColor: AppColors.xffF44336,
  );
}

generalErrorSnack(String title, String error) {
  showSnackBar(
    title,
    error,
    backgroundColor: AppColors.xffF44336,
  );
}


successSnack(String success, {Function()? onOK}) {
  showSnackBar(AppString.success, success,
      backgroundColor: AppColors.xff34B233, onOK: onOK);
}

warningSnack(String warning) {
  showSnackBar(AppString.warning, warning,
      backgroundColor: AppColors.xffffc060,
      textColor: LightTheme.chipSelectedDark);
}


showSnackBar(String title, String message,
    {Color? backgroundColor, Color? textColor, Function()? onOK}) {
  DialogService.generalDialog(title, message, backgroundColor, onOK: onOK);
}


showResetPasswordSnackBar(String message) {

  DialogService.resetPasswordDialog("Reset Password", message, AppColors.xffF44336);

}

showDialogWithIcon(IconData icon, String title, String body, String actionText, Color? backgroundColor) async {
  DialogService.dialogWithIcon(icon, title, body, actionText, backgroundColor);
}

showProceedDialogWithIcon(IconData icon, String title, String body, Color? backgroundColor, Function() onProceed) async {
  DialogService.proceedDialogWithIcon(icon, title, null, body, backgroundColor, onProceed);
}

showVerifyDialogWithIcon(IconData icon, String title, String body, Color? backgroundColor, Function() onProceed) async {
  DialogService.proceedDialogWithIcon(icon, title, "Go Verify", body, backgroundColor, onProceed);
}

class DialogService {
  static Future<DialogsAction> generalDialog(
      String title, String body, Color? backgroundColor, {Function()? onOK}) async {
    final action = await Get.dialog(
      AlertDialog(
        backgroundColor: backgroundColor,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.16,
          ),
        ),
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
        actions: <Widget>[
          InkWell(
            onTap: () {
              Get.back(result: DialogsAction.cancel);
              if (onOK != null) {
                onOK();
              }
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Color(0xff6ACC86),
              ),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFFffffff),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return (action != null) ? action : DialogsAction.cancel;
  }


  static Future<DialogsAction> dialogWithIcon(
      IconData icon,
      String title, String body, String actionText, Color? backgroundColor) async {
    final action = await Get.dialog(
      AlertDialog(
        backgroundColor: backgroundColor,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        icon: Icon(icon, color: Colors.white, size: 40,),
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
        actions: <Widget>[
          InkWell(
            onTap: () {
              Get.back(result: DialogsAction.cancel);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Color(0xff6ACC86),
              ),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFFffffff),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> proceedDialogWithIcon(
      IconData icon,
      String title, String? actionText, String body, Color? backgroundColor,  Function() onProceed) async {
    final action = await Get.dialog(
      AlertDialog(
        backgroundColor: backgroundColor,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        icon: Icon(icon, color: Colors.white, size: 40,),
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
        actions: <Widget>[
          InkWell(
            onTap: () {
              Get.back(result: DialogsAction.cancel);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xff2BA6CE),
              ),
              child: Text(
                'Back',
                style: TextStyle(
                  color: Color(0xFFffffff),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.back(result: DialogsAction.cancel);
              onProceed();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xff6ACC86),
              ),
              child: Text(
                actionText ?? 'Proceed',
                style: TextStyle(
                  color: Color(0xFFffffff),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return (action != null) ? action : DialogsAction.cancel;
  }


  static Future<DialogsAction> dialogWithOkAndCancel(
      IconData icon,
      String title, String body, String actionText, Color? backgroundColor) async {
    final action = await Get.dialog(
      AlertDialog(
        backgroundColor: backgroundColor,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        icon: Icon(icon, color: Colors.white, size: 40,),
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
        actions: <Widget>[
          InkWell(
            onTap: () {
              Get.back(result: DialogsAction.cancel);
              Restart.restartApp();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Colors.red,
              ),
              child: Text(
                actionText,
                style: TextStyle(
                  color: Color(0xFFffffff),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.back(result: DialogsAction.cancel);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Colors.red,
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
      ),
    );
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> resetPasswordDialog(
      String title, String body, Color? backgroundColor) async {
    final action = await Get.dialog(
      AlertDialog(
        backgroundColor: backgroundColor,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.16,
          ),
        ),
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
        actions: <Widget>[
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Color(0xff6ACC86),
              ),
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Color(0xFFffffff),
                ),
              ),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     Get.to(() => ResetPasswordPage());
          //   },
          //   child: Container(
          //     padding: EdgeInsets.all(10),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.all(Radius.circular(25)),
          //       color: Color(0xffffa800),
          //     ),
          //     child: Text(
          //       'Reset',
          //       style: TextStyle(
          //         color: Color(0xFFffffff),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
    return (action != null) ? action : DialogsAction.cancel;
  }

}