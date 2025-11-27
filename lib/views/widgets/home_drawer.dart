import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../colors/app_colors.dart';
import '../../common/perferenceVisibility.dart';
import '../../common/perfrance.dart';
import '../../common/string.dart';
import '../../controllers/main_page_controller.dart';
import '../../routes/app_pages.dart';
import '../pages/settings_page.dart';
import 'custom_title.dart';
import 'dialogs.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}
// HomeDrawer({super.key});

class _HomeDrawerState extends State<HomeDrawer> {
  final MethodChannel methodChannel = const MethodChannel('app/version');
  final MainPageController controller = Get.put(MainPageController());

  var versionName = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final Future versionFuture = methodChannel.invokeMethod('getVersionName');
        versionFuture.then((version) {
          setState(() {
            versionName = version;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.appBackgroundColor,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
          child: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Image(
                                image:
                                AssetImage('assets/images/orbaic_logo.png'),
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                              Center(
                                  child: IconButton(
                                    onPressed: () {
                                      print("Hello Sakib");
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              PreferenceVisibility(
                                preferenceKey: Pref.miningEnabledStatus,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: const Image(
                                    height: 50,
                                    width: 50,
                                    image: AssetImage('assets/images/avatar.png'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                        () => PreferenceVisibility(
                                      preferenceKey: Pref.miningEnabledStatus,
                                      child: Text(
                                        controller.fullName.value ?? "",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.59,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(
                                        () => PreferenceVisibility(
                                      preferenceKey: Pref.miningEnabledStatus,
                                      child: Text(
                                        controller.email.value ?? "",
                                        style: TextStyle(
                                          color: Colors.white
                                              .withOpacity(0.6000000238418579),
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.30,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          PreferenceVisibility(
                            preferenceKey: Pref.miningEnabledStatus,
                            child: CustomTitle(
                              onTap: () async {
                                String link =
                                    "https://orbaic.com/mining_rules.php";
                                final action =
                                await Dialogs.leftAppDialog(context, link);
                              },
                              leading: Image(
                                image: AssetImage(
                                    'assets/images/orbaic_white_logo.png'),
                                height: 32,
                                width: 32,
                              ),
                              title: Text(
                                'mining_rules'.tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.44,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.28,
                                ),
                              ),
                            ),
                          ),
                          PreferenceVisibility(
                            preferenceKey: Pref.miningEnabledStatus,
                            child: CustomTitle(
                              onTap: () async {
                                String link =
                                    "https://orbaic.com/whitepaper.php";
                                final action =
                                await Dialogs.leftAppDialog(context, link);
                              },
                              leading: Image(
                                image: AssetImage(
                                    'assets/images/white_paper_icon.png'),
                                height: 28,
                                width: 28,
                              ),
                              title: Text(
                                'white_paper'.tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.44,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.28,
                                ),
                              ),
                            ),
                          ),
                          PreferenceVisibility(
                            preferenceKey: Pref.miningEnabledStatus,
                            child: CustomTitle(
                              onTap: () {
                                Get.to(() => SettingsPage());
                                closeDrawer(context);
                              },
                              leading: Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 32,
                              ),
                              title: Text(
                                'settings'.tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.44,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.28,
                                ),
                              ),
                            ),
                          ),
                          PreferenceVisibility(
                            preferenceKey: Pref.miningEnabledStatus,
                            child: CustomTitle(
                              onTap: () async {
                                String link = "https://orbaic.com/faq.php";
                                final action =
                                await Dialogs.leftAppDialog(context, link);
                              },
                              leading: Icon(
                                Icons.info_outline_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                              title: Text(
                                'faq'.tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.44,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.28,
                                ),
                              ),
                            ),
                          ),
                          PreferenceVisibility(
                            preferenceKey: Pref.miningEnabledStatus,
                            child: CustomTitle(
                              onTap: () async {
                                String link =
                                    "https://orbaic.com/terms_condition.php";
                                final action =
                                await Dialogs.leftAppDialog(context, link);
                              },
                              leading: Image(
                                image: AssetImage(
                                    'assets/images/terms_condition_icon.png'),
                                height: 32,
                                width: 32,
                              ),
                              title: Text(
                                'terms_and_conditions'.tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.44,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.28,
                                ),
                              ),
                            ),
                          ),
                          CustomTitle(
                            onTap: () async {
                              String link = controller.isMiningEnabled.value
                                  ? "https://orbaic.com/privecy_policy.php"
                                  : "https://www.orbaic.com/privecy_policy_ios.php";
                              final action =
                              await Dialogs.leftAppDialog(context, link);
                            },
                            leading: Image(
                              image: AssetImage(
                                  'assets/images/privacy_policy_icon.png'),
                              height: 32,
                              width: 32,
                            ),
                            title: Text(
                              'privacy_policy'.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.44,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.28,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      //    Spacer(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                child: Text(
                                  'follow_us_on_social'.tr,
                                  style: TextStyle(
                                    color: Colors.white
                                        .withOpacity(0.6000000238418579),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            runSpacing: 5,
                            spacing: 5,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                    onTap: () async {
                                      String link =
                                          "https://t.me/OrbaicEnglish";
                                      final action =
                                      await Dialogs.leftAppDialog(
                                          context, link);
                                    },
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/telegram_icon.png'),
                                      height: 32,
                                      width: 32,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                    onTap: () async {
                                      String link =
                                          "https://twitter.com/Orbaicproject?s=08";
                                      final action =
                                      await Dialogs.leftAppDialog(
                                          context, link);
                                    },
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/twitter_icon.png'),
                                      height: 32,
                                      width: 32,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                    onTap: () async {
                                      String link =
                                          "https://www.facebook.com/orbaic/";
                                      final action =
                                      await Dialogs.leftAppDialog(
                                          context, link);
                                    },
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/fb_icon.png'),
                                      height: 32,
                                      width: 32,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                    onTap: () async {
                                      String link =
                                          "https://www.instagram.com/orbaicecosystem/";
                                      final action =
                                      await Dialogs.leftAppDialog(
                                          context, link);
                                    },
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/insta_icon.png'),
                                      height: 32,
                                      width: 32,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                    onTap: () async {
                                      String link =
                                          "https://www.youtube.com/@orbaicecosystem";
                                      final action =
                                      await Dialogs.leftAppDialog(
                                          context, link);
                                    },
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/youtube_icon.png'),
                                      height: 32,
                                      width: 32,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  onTap: () async {
                                    String link =
                                        "https://medium.com/@orbaic.com";
                                    final action = await Dialogs.leftAppDialog(
                                        context, link);
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.medium,
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  onTap: () async {
                                    String link =
                                        "https://www.reddit.com/user/orbaic/";
                                    final action = await Dialogs.leftAppDialog(
                                        context, link);
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.reddit,
                                    size: 28,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  onTap: () async {
                                    String link =
                                        "https://discord.com/login?redirect_to=%2Fchannels%2F1139218711534907424%2F1139218712407318540";
                                    final action = await Dialogs.leftAppDialog(
                                        context, link);
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.discord,
                                    size: 28,
                                    color: Color(0xff7289d9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              bool logoutStatus = await controller.logout();
                              final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              if (logoutStatus) {
                                prefs.remove(Pref.token);
                                await prefs.remove('index');
                                await prefs.remove(AppString.quizQuestion);
                                await prefs.remove('isLeft');
                                Get.deleteAll();
                                Get.offAllNamed(Routes.LOGIN);
                              }
                            },
                            child: CustomTitle(
                              leading: PreferenceVisibility(
                                preferenceKey: Pref.miningEnabledStatus,
                                child: const Icon(
                                  Icons.power_settings_new_outlined,
                                  color: Color(0xFFFF6442),
                                ),
                              ),
                              title: PreferenceVisibility(
                                preferenceKey: Pref.miningEnabledStatus,
                                child: const Text(
                                  'Log-out',
                                  style: TextStyle(
                                    color: Color(0xFFFF6442),
                                    fontSize: 15.44,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.28,
                                  ),
                                ),
                              ),
                              trailing: Text(
                                'v$versionName',
                                style: TextStyle(
                                  color: Color(0xFF777777),
                                  fontSize: 15.44,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.28,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: Image(
                        image: AssetImage('assets/images/drawer_side_icon.png'),
                        width: 30,
                      )),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  void closeDrawer(context) {
    Scaffold.of(context).closeDrawer();
  }
}