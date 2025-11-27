import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_plus/share_plus.dart';
import '../../ads/AdManager.dart';
import '../../colors/app_colors.dart';
import '../../controllers/team_page_controller.dart';
import '../pages/all_team_members_page.dart';
import '../widgets/dialogs.dart';

class TeamPage extends StatelessWidget {
  TeamPage({super.key});

  final _cache = GetStorage();
  TeamPageController controller = Get.put(TeamPageController());
  int index = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        color: AppColors.appSecondaryBackgroundColor,
        child: Obx(
              () => controller.teamModel.value != null
              ? ListView(
            children: [
              Container(
                width: Get.width - 48,
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.appBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  children: [
                    Text(
                      'My Invitation Code',
                      style: TextStyle(
                          fontSize: 20, color: Color(0xffc0c0c0)),
                    ),
                    Divider(
                      color: Color(0x1aFFFFff),
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: Get.width - 160,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(25)),
                            color: Color(0x1aFFFFff),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${controller.teamModel.value?.result?.referralCode}',
                                style: TextStyle(
                                  color: Color(0x80FFFFff),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(
                                    text:
                                    '${controller.teamModel.value?.result?.referralCode}',
                                  )).then((_) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                          content:
                                          Text('text_copied'.tr)),
                                    );
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.appSecondaryColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.copy_rounded,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Copy',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.59,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            shareAppInvite(controller.teamModel.value
                                ?.result?.referralCode ??
                                "NoCode");
                            // final result = await Share.share('Orbaic is a Layer 1 Web3 project. Kickstart your ACI token mining journey by downloading the app and signing up. Don\'t forget to enter my referral code in the team section to instantly claim your 2 ACI tokens. Build your team and enjoy an additional 5% Boost when your team members are actively mining.\n\nMy Referral Code: ${controller.teamModel.value?.result?.referralCode}\n\nDownload Android app: https://play.google.com/store/apps/details?id=com.orbaic.miner');
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(25)),
                              color: Color(0x1aFFFFff),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.appSecondaryColor,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.ios_share_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Share',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.59,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: Get.width - 48,
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.appBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Image(
                        image: AssetImage('assets/images/gift_image.png'),
                        height: 160,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Team (${controller.teamModel.value?.result?.teamMember?.team?.teamMembers?.length ?? 0})',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.14,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => GetAllTeamMembersPage());
                          },
                          child: Text(
                            'View All >>',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF64D2FF),
                              fontSize: 13.22,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.14,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Builder(builder: (context) {
                      if (controller.teamModel.value?.result?.teamMember
                          ?.team?.teamMembers !=
                          null &&
                          controller.teamModel.value!.result!.teamMember!
                              .team!.teamMembers!.length <
                              index) {
                        index = controller.teamModel.value!.result!
                            .teamMember!.team!.teamMembers!.length;
                      }
                      return Wrap(
                        // crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.start,
                        children: [
                          if (controller.teamModel.value?.result
                              ?.teamMember?.team?.teamMembers !=
                              null)
                            for (var teamMember in controller
                                .teamModel
                                .value
                                ?.result
                                ?.teamMember
                                ?.team
                                ?.teamMembers!
                                .sublist(0, index) ??
                                [])
                              Padding(
                                padding: EdgeInsets.all(2),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10)),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xff364156),
                                          Color(0xff212D40)
                                        ]),
                                  ),
                                  width: Get.width * 0.15,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                            child: Image(
                                              height: 40,
                                              width: 40,
                                              image: AssetImage(
                                                  'assets/images/avatar.png'),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          // Adjust this value as needed for spacing
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              // Adjust this value as needed for spacing
                                              Container(
                                                width: 8,
                                                height: 8,
                                                decoration:
                                                ShapeDecoration(
                                                  color: teamMember
                                                      .isMining ==
                                                      false
                                                      ? Color(0x1A61C7C4)
                                                      : Color(0xFF61C7C4),
                                                  shape: CircleBorder(),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ],
                      );
                    }),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Color(0x66FFFFFF),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Ref Earn',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.59,
                          ),
                        ),
                        Row(
                          children: [
                            Image(
                              image: AssetImage(
                                  'assets/images/colored_logo.png'),
                              height: 32,
                              width: 32,
                            ),
                            // Text('${controller.totalRefEarn} ACI',
                            Text(
                              '${(controller.totalRefEarn.abs() < 1e-2 ? 0 : controller.totalRefEarn).toStringAsFixed(2)} ACI',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.44,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(
                    () => Visibility(
                  visible:
                  !controller.teamModel.value!.result!.hasReferredBy!,
                  child: Container(
                    width: Get.width - 48,
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.appBackgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(children: [
                      /*Row(
                        children: [
                          Text(
                            'Your Referral Code',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.59,
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Image(
                            image: AssetImage('assets/images/refer_code_icon.png'),
                            height: 32,
                            width: 40,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '${controller.teamModel.value?.result?.referralCode}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.44,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () async {
                              await Clipboard.setData(ClipboardData(
                                text: '${controller.teamModel.value?.result?.referralCode}',
                              )).then((_){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('text_copied'.tr)),
                                );
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  'copy',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.44,
                                  ),
                                ),
                                Icon(
                                  Icons.copy_rounded,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),*/
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Get 2 tokens by submitting a referral code.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.59,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Divider(
                        color: Color(0x66FFFFFF),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20)),
                          color: Color(0x1aFFFFff),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Image(
                                image: AssetImage(
                                    'assets/images/refer_code_icon.png'),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 150,
                              child: TextField(
                                controller: controller.refController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Code',
                                  hintStyle:
                                  TextStyle(color: Color(0x80FFFFff)),
                                ),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                bool isAdReady =
                                await AdManager.instance.isAdReady();
                                if (isAdReady) {
                                  await AdManager.instance.showAd();
                                }
                                controller.joinReferral(
                                    controller.refController.text,
                                    context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.appSecondaryColor,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15)),
                                ),
                                child: Text(
                                  'SUBMIT',
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
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          )
              : Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Future<void> shareAppInvite(String referralCode) async {
    const String androidUrl =
        'https://play.google.com/store/apps/details?id=com.orbaic.miner';
    const String iosUrl = 'https://apps.apple.com/app/id1234567890';

    // Determine platform and set the appropriate app link
    final String appUrl =
    defaultTargetPlatform == TargetPlatform.iOS ? iosUrl : androidUrl;

    final String message =
        "Orbaic is a Layer 1 Web3 project. Kickstart your ACI token mining journey by downloading the app and signing up. "
        "Don't forget to enter my referral code in the team section to instantly claim your 2 ACI tokens. "
        "Build your team and enjoy an additional 5% Boost when your team members are actively mining.\n\n"
        "My Referral Code: $referralCode\n\n"
        "Download the app: $appUrl";

    try {
      await Share.share(message);
    } on PlatformException catch (e) {
      debugPrint("Error sharing the message: $e");
    }
  }
}