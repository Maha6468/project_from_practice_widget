import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_from_practice_widget/views/quiz_views/quize_structure_page.dart';

import '../../colors/app_colors.dart';
import '../../common/perferenceVisibility.dart';
import '../../common/perfrance.dart';
import '../../controllers/quiz_controller.dart';



class QuizHomePage extends StatelessWidget {
  QuizHomePage({super.key});
  final QuizController controller = Get.put(QuizController());
  //  final _cache = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appSecondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appSecondaryColor,
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
              onTap: (){
                Get.back();
              },
              child: Image(image: AssetImage('assets/images/appbar_back_arrow.png'),height: 32, width: 32,)),
        ),
        title: const Text(
          'Start Quiz',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.59,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            Center(
              child: InkWell(
                onTap: () async {
                  //new qz code
                  //if(!controller.prefs.containsKey("index") && !controller.prefs.containsKey("isLeft"))
                  //{
                  await controller.startQuiz();
                  // }
                  controller.startTimer();
                  Get.to(() => QuizStructurePage());
                },
                child: Container(
                  width: Get.width/1.3,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  //margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.appSecondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/images/quiz_icon.png'),height: 20, width: 20, color: Colors.white,),
                      SizedBox(width: 10,),
                      Text(
                        'START QUIZ NOW',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.59,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12,),
            PreferenceVisibility(
              preferenceKey: Pref.miningEnabledStatus,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    Text(
                      'Each correct Answer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.59,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Image(image: AssetImage('assets/images/colored_logo.png'), height: 20, width: 20,),
                        SizedBox(width: 4,),
                        Text(
                          'ACI  ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.59,
                          ),
                        ),
                        Text(
                          '0.5',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0.05,
                            letterSpacing: 0.59,
                          ),
                        )
                      ],
                    )
                  ],),
                  Column(children: [
                    Text(
                      'Each wrong Answer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.59,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Image(image: AssetImage('assets/images/orbaic_white_logo.png'), height: 20, width: 20,),
                        SizedBox(width: 4,),
                        Text(
                          'ACI  ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.59,
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0.05,
                            letterSpacing: 0.59,
                          ),
                        )
                      ],
                    )
                  ],),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Divider(),
            SizedBox(height: 5,),
            PreferenceVisibility(
              preferenceKey: Pref.miningEnabledStatus,
              child: Text(
                'Frequently Asked Questions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 14.95,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            PreferenceVisibility(
              preferenceKey: Pref.miningEnabledStatus,
              child: Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.appBackgroundColor,
                  border: Border(left: BorderSide(
                    color: AppColors.appSecondaryColor,
                    width: 2.0,
                  )),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Theme(
                  data: ThemeData().copyWith(
                      dividerColor: Colors.transparent),
                  child: ExpansionTile(
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      title: Text(
                        'What is orbaic Quiz?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.59,
                        ),
                      ),
                      expandedCrossAxisAlignment:
                      CrossAxisAlignment.start,
                      expandedAlignment:
                      Alignment.centerLeft,
                      childrenPadding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 0,
                          bottom: 0),
                      children: <Widget>[
                        Text(
                          'The Orbaic Quiz gives miners a chance for extra rewards, but it\'s only available for a limited time. There are five sets of quizzes every day, and each miner can do up to 10 quizzes. After finishing and submitting, the next set of quizzes will be ready in 12 hours. Remember, the reward ratio might change after Orbaic makes an announcement.',
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                      ]),
                ),
              ),
            ),

            // Container(
            //   padding: EdgeInsets.all(6),
            //   margin: EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //     color: AppColors.appBackgroundColor,
            //     borderRadius: BorderRadius.all(Radius.circular(15)),
            //     border: Border(left: BorderSide(
            //       color: AppColors.appSecondaryColor,
            //       width: 2.0,
            //     )),
            //   ),
            //   child: Theme(
            //     data: ThemeData().copyWith(
            //         dividerColor: Colors.transparent),
            //     child: ExpansionTile(
            //         iconColor: Colors.white,
            //         collapsedIconColor: Colors.white,
            //         title: Text(
            //           'Can I withdraw my Quiz Rewards?',
            //         style: TextStyle(
            //         color: Colors.white,
            //           fontSize: 15,
            //           fontFamily: 'Poppins',
            //           fontWeight: FontWeight.w500,
            //           letterSpacing: 0.59,
            //         ),
            //     ),
            //         expandedCrossAxisAlignment:
            //         CrossAxisAlignment.start,
            //         expandedAlignment:
            //         Alignment.centerLeft,
            //         childrenPadding: EdgeInsets.only(
            //             left: 15,
            //             right: 15,
            //             top: 0,
            //             bottom: 0),
            //         children: <Widget>[
            //           Text(
            //             'Yes, you can withdraw your Quiz Rewards. You\'ll be eligible to withdraw your rewards "ACI tokens" either in phase 4 or after completing the KYC verification process.',
            //             style: TextStyle(
            //               color: Colors.white,
            //             ),),
            //         ]),
            //   ),
            // ),

            PreferenceVisibility(
              preferenceKey: Pref.miningEnabledStatus,
              child: Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.appBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border(left: BorderSide(
                    color: AppColors.appSecondaryColor,
                    width: 2.0,
                  )),
                ),
                child: Theme(
                  data: ThemeData().copyWith(
                      dividerColor: Colors.transparent),
                  child: ExpansionTile(
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      title: Text(
                        'Why can\'t I find the submit button?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.59,
                        ),
                      ),
                      expandedCrossAxisAlignment:
                      CrossAxisAlignment.start,
                      expandedAlignment:
                      Alignment.centerLeft,
                      childrenPadding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 0,
                          bottom: 0),
                      children: <Widget>[
                        Text(
                          'There\'s a possibility that you can\'t find the submit button due to various reasons:\n- It could be a network issue, such as a weak connection.\n- Your device might have active blocking systems or location restrictions.\n- Attempting to abuse the app or break the rules may also prevent you from accessing the submit button.\n- There could be other underlying issues as well.',
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                      ]),
                ),
              ),
            ),

            PreferenceVisibility(
              preferenceKey: Pref.miningEnabledStatus,
              child: Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.appBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border(left: BorderSide(
                    color: AppColors.appSecondaryColor,
                    width: 2.0,
                  )),
                ),
                child: Theme(
                  data: ThemeData().copyWith(
                      dividerColor: Colors.transparent),
                  child: ExpansionTile(
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      title: Text(
                        'What should I do if I cannot locate the submit button?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.59,
                        ),
                      ),
                      expandedCrossAxisAlignment:
                      CrossAxisAlignment.start,
                      expandedAlignment:
                      Alignment.centerLeft,
                      childrenPadding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 0,
                          bottom: 0),
                      children: <Widget>[
                        Text(
                          'Before starting the Orbaic quiz, make sure to check a few things:\n- Check if your network connection is weak. If it is, try connecting to a stronger network or wait a few minutes before attempting again.\n- Ensure that your location is unlocked and any blocking apps are disabled.\n- Avoid using a VPN while starting the quiz.\n- Wait for a while to see if the submit button appears.',
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                      ]),
                ),
              ),
            ),

            PreferenceVisibility(
              preferenceKey: Pref.miningEnabledStatus,
              child: Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.appBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border(left: BorderSide(
                    color: AppColors.appSecondaryColor,
                    width: 2.0,
                  )),
                ),
                child: Theme(
                  data: ThemeData().copyWith(
                      dividerColor: Colors.transparent),
                  child: ExpansionTile(
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      title: Text(
                        'Why this point?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.59,
                        ),
                      ),
                      expandedCrossAxisAlignment:
                      CrossAxisAlignment.start,
                      expandedAlignment:
                      Alignment.centerLeft,
                      childrenPadding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 0,
                          bottom: 0),
                      children: <Widget>[
                        Text(
                          'By solving quiz you will rank you profile and who will top rank they will get extra offer.',
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                      ]),
                ),
              ),
            ),

            // Container(
            //   margin: EdgeInsets.all(12),
            //   padding: EdgeInsets.all(6),
            //   decoration: BoxDecoration(
            //     color: AppColors.appBackgroundColor,
            //     borderRadius: BorderRadius.all(Radius.circular(15)),
            //     border: Border(left: BorderSide(
            //       color: AppColors.appSecondaryColor,
            //       width: 2.0,
            //     )),
            //   ),
            //   child: Theme(
            //     data: ThemeData().copyWith(
            //         dividerColor: Colors.transparent),
            //     child: ExpansionTile(
            //         iconColor: Colors.white,
            //         collapsedIconColor: Colors.white,
            //         title: Text(
            //           'Where can I view my tokens after submitting the quiz?',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 15,
            //             fontFamily: 'Poppins',
            //             fontWeight: FontWeight.w500,
            //             letterSpacing: 0.59,
            //           ),
            //         ),
            //         expandedCrossAxisAlignment:
            //         CrossAxisAlignment.start,
            //         expandedAlignment:
            //         Alignment.centerLeft,
            //         childrenPadding: EdgeInsets.only(
            //             left: 15,
            //             right: 15,
            //             top: 0,
            //             bottom: 0),
            //         children: <Widget>[
            //           Text(
            //             'After submission, you can promptly see your ACI tokens in both your wallet and dashboard. Take a moment to verify your balance.',
            //             style: TextStyle(
            //               color: Colors.white,
            //             ),),
            //         ]),
            //   ),
            // ),
            SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }
}
