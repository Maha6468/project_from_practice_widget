import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors/app_colors.dart';


class StackingFAQPage extends StatelessWidget {
  const StackingFAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appSecondaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appSecondaryColor,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image(
                  image: AssetImage('assets/images/appbar_back_arrow.png'),
                  height: 32,
                  width: 32,
                )),
          ),
          title: Text(
            'Staking FAQ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.59,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Container(
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
                        'What is the staking ratio for ACI Token?',
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
                          '1-Year Staking: Receive 130% of the ACI Token, including the principal amount.\n2-Year Staking: Receive 150% of the ACI Token, including the principal amount.\n3-Year Staking: Receive 180% of the ACI Token, including the principal amount.\n4-Year Staking: Receive 200% of the ACI Token, including the principal amount.',
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                      ]),
                ),
              ),

              Container(
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
                        'What is the minimum and maximum amount of ACI Tokens that can be staked at one time?',
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
                          'Minimum: 5 ACI Tokens can be staked at one time.\nMaximum: There is no limit to the number of ACI Tokens that can be staked at one time.',
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                      ]),
                ),
              ),



              Container(
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
                        'When can I release staked tokens?',
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
                          'Tokens can be released, including the benefits, once the staking period has ended.',
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                      ]),
                ),
              ),


              Container(
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
                        'Can I stake multiple times?',
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
                          'Yes, you can stake multiple times as long as you have the minimum required tokens in your wallet.',
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                      ]),
                ),
              ),
            ],
          ),
        ));
  }
}