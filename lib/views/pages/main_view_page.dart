import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/perferenceVisibility.dart';
import '../../common/perfrance.dart';
import '../../controllers/main_page_controller.dart';
import '../../enums.dart';
import '../navigation_views/home_page.dart';
import '../navigation_views/support_page.dart';
import '../navigation_views/team_page.dart';
import '../navigation_views/wallet_page.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/home_drawer.dart';
import '../widgets/main_app_bar.dart';

class MainViewPage extends GetView<MainPageController> {
  const MainViewPage({super.key});

  //final MainPageController controller = Get.put(MainPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Obx(() => getSelectedWidget(controller.selectedBottomBarItem.value)),
      bottomNavigationBar: PreferenceVisibility(
          preferenceKey: Pref.miningEnabledStatus,
          child: BottomBar()
      ),
      drawer: HomeDrawer(),
    );
  }

  Widget getSelectedWidget  (PageName pageName){
    switch(pageName){
      case PageName.home:
        return FeatureDiscovery.withProvider(
            persistenceProvider: NoPersistenceProvider(),
            child: HomePage()
          // child: QuizHomePage()
        );
      case PageName.wallet: return WalletPage();
      case PageName.team: return TeamPage();
      case PageName.support: return SupportPage();
      default: return HomePage();
    }
  }

}