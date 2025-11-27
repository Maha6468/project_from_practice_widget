import 'package:feature_discovery/feature_discovery.dart';
import 'package:get/get.dart';

import '../bindings.dart';
import '../views/pages/login_page.dart';
import '../views/pages/main_view_page.dart';
import '../views/pages/splash_screen.dart';

appRoutes() => [
  GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: AuthBinding()
  ),
  GetPage(
      name: '/splash',
      page: () => SplashScreen(),
      binding: SplashBinding()
  ),
  GetPage(
      name: '/main_view',
      page: () => FeatureDiscovery.withProvider(
          persistenceProvider: NoPersistenceProvider(),
          child: MainViewPage()
      ),      binding: MainBinding()
  ),

];