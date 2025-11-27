import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors/app_colors.dart';

class ProfileFaqPage extends StatelessWidget {
  const ProfileFaqPage({super.key});

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
            'Profile FAQ',
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
                        'Can I change my profile name?',
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
                          'You can change your profile name once after registration. If you need to modify it again, please contact the Orbaic Customer Support team for assistance.',
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
                        'Can I change my phone number?',
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
                          'Direct changes to your phone number aren’t available. To update it, please reach out to our support team with the reason for the change.',
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
                        'Can I change my email address?',
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
                          'Email address changes aren’t directly possible. To update your email, please submit a request to our support team.',
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
                        'What happens if my name is incorrect?',
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
                          'An incorrect name can delay your Know Your Customer (KYC) verification and may lead to your account not being approved. Ensuring your name matches official identification documents is crucial for a smooth verification process.',
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
                        'How many times can I change my name?',
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
                          'You’re allowed to change your name once after registration. If further changes are necessary, please contact the Orbaic Customer Support team for assistance.',
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