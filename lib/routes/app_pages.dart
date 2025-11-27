import 'package:get/get.dart';

import '../views/pages/login_page.dart';
import '../views/pages/main_view_page.dart';
import '../views/pages/splash_screen.dart';
part 'app_routes.dart';
class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [

    GetPage(
      name: _Paths.SPLASH,
      page: () =>  SplashScreen(),
      // binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () =>  LoginPage(),
      // binding: LoginBinding(),
    ),

    GetPage(
      name: _Paths.MAIN,
      page: () =>  MainViewPage(),
      // binding: LoginBinding(),
    ),
  ];
}