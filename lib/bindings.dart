import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'controllers/home_page_controller.dart';
import 'controllers/main_page_controller.dart';
import 'controllers/splash_controller.dart';


class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SplashController());
  }

}


class AuthBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthController());
  }

}


class MainBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MainPageController());
  }

}

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(HomePageController());
  }

}