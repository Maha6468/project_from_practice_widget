import 'dart:ui';




import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppColors {
  const AppColors._();

  static bool isDarkTheme() {
    return Get.isDarkMode;
  }

  static changeThemeMode() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      // AppPref().isDark = false;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      // AppPref().isDark = true;
    }
  }

  static Color blackWhiteColor() {
    return isDarkTheme()
        ? DarkTheme.chipSelectedDark
        : LightTheme.chipSelectedDark;
  }

//==============================================================================
// ** Single Colors **
//==============================================================================

  static const Color trans = Colors.transparent;
  static const Color black = Colors.black;
  static const Color red = Colors.red;
  static const Color gray = Colors.grey;
  static const Color white = Colors.white;
  static const Color appColor = Color(0xff2f466e);

  static const Color lightGray = Color(0xffD6D6D6);
  static const Color xffF2F2F2 = Color(0xffF2F2F2);
  static const Color xffB70821 = Color(0xffB70821);
  static const Color page1 = Color(0xffa4e6fe);
  static const Color page2 = Color(0xffbb90da);
  static const Color xffF6AF3C = Color(0xfff6af3c);
  static const Color xfff0f3f5 = Color(0xfff0f3f5);
  static const Color xff95c1fe = Color(0xff81b6ff);
  static const Color appTextColor = Color(0xffDA2D3F);
  static const Color xFFB1021B = Color(0xFFB1021B);
  static const Color xff890014 = Color(0xff890014);
  static const Color textFieldColor = Color(0xffEEEEE);
  static const Color fieldBorderColor = Color(0xffEEEEEE);
  static const Color xff69696C = Color(0xff69696C);
  static const Color xffDA6B6B = Color(0xffDA6B6B);
  static const Color xffB1021C = Color(0xffB1021C);
  static const Color xff5B5B5E = Color(0xff5B5B5E);
  static const Color xffB3B3B3 = Color(0xffB3B3B3);
  static const Color xffC4C4C4 = Color(0xffC4C4C4);
  static const Color xffD0D2D1= Color(0xffD0D2D1);
  static const Color xffD9D9D9= Color(0xffD9D9D9);
  static const Color xffBCBCBC= Color(0xffBCBCBC);
  static const Color xffB70922= Color(0xffB70922);
  static const Color xffFF5567= Color(0xffFF5567);
  static const Color xffBF1128= Color(0xffBF1128);
  static const Color xffEFEFEF= Color(0xffEFEFEF);
  static const Color xffffc060 =  Color(0xFFffc060);
  static const Color xff34B233 =  Color(0xff34B233);
  static const Color xffF44336 =  Color(0xffF44336);
  static Color appBackgroundColor = const Color(0xff212238);
  static Color appTextFieldColor = const Color(0xff364156);
  static Color appSecondaryColor = const Color(0xff41918B);
  static Color appSecondaryBackgroundColor = const Color(0xff364156);
  static Color appBottomBarSelectedColor = const Color(0xff61C7C4);
  static Color appRippleEffectColor = const Color(0xff61C7C4);
}

class DarkTheme {
  static const chipSelectedDark = Color(0xffFFFFFF);
}

class LightTheme {
  static const chipSelectedDark = Color(0xff000000);
}


