import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_from_practice_widget/routes/app_pages.dart';
import 'package:project_from_practice_widget/utility/app_translation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ads/AdManager.dart';
import 'common/app_loading.dart';
import 'common/firebase_notification/firebase_notification.dart';
import 'common/global_widget.dart';
import 'common/perfrance.dart';
import 'common/string.dart';
import 'common/wrapper.dart';
import 'firebase_options.dart';
import 'colors/app_colors.dart';

bool? cancelWrapper = false;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceHelper.instance.createSharedPref();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    name: "orbaic-6832f",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseNotification.instance.initialize();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  await AdManager().initialize();
  await GetStorage.init();
  final mainCache = GetStorage();
  Locale locale = const Locale('en', 'US');
  if (!prefs.containsKey("clearDatta")) {
    await mainCache.erase();
    await prefs.clear();
    await prefs.setBool("clearDatta", true);
  }
  if (prefs.containsKey(AppString.cancelWrapper)) {
    cancelWrapper = prefs.getBool(AppString.cancelWrapper);
  }
  if (mainCache.hasData(AppString.languageSelected)) {
    String localeString = await mainCache.read(AppString.languageSelected);
    String separator = ",";
    List<String> substrings = localeString.split(separator);
    String param1 = substrings.first;
    String param2 = substrings.join(separator);
    locale = Locale(param1, param2);
  }
  print("MyLocal ${locale.languageCode}");
  ChuckerFlutter.showOnRelease = false;
  ChuckerFlutter.showNotification = true;



  runApp(MyApp(locale));
}

//maha
extension on Function() {
  Future<void> createSharedPref() async {}
}


class MyApp extends StatelessWidget {
  final Locale locale;

  MyApp(this.locale, {super.key});

  final languageCache = GetStorage();

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      minTextAdapt: true,
      splitScreenMode: true,
      child: ConnectivityAppWrapper(
        app: GetMaterialApp(
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
            ChuckerFlutter.navigatorObserver
          ],
          locale: locale,
          fallbackLocale: const Locale('en', 'US'),
          translations: AppTranslation(),
          title: 'Orbaic Miner',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff41918B)),
              useMaterial3: true,
              canvasColor: AppColors.appBackgroundColor),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: EasyLoading.init(
            builder: (context, child) {
              hideLoading();
              if (cancelWrapper!) {
                return ConnectivityWidgetWrapper(
                  child: child!,
                );
              } else{
                return ConnectivityWidgetWrapper(
                  offlineWidget: const NoInternet(),
                  child: child!,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}