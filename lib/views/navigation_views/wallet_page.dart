import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../colors/app_colors.dart';
import '../../common/global_widget.dart';
import '../../common/perferenceVisibility.dart';
import '../../common/perfrance.dart';
import '../../controllers/wallet_page_controller.dart';
import '../merchant_views/merchant_history.dart';
import '../merchant_views/merchant_offer.dart';
import '../reward_views/reward_history.dart';
import '../widgets/dialogs.dart';
import '../widgets/shake_widget.dart';

class WalletPage extends StatelessWidget {
  WalletPage({super.key});
  final WalletPageController controller = Get.put(WalletPageController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      color: AppColors.appSecondaryBackgroundColor,
      child: Container(
        padding: EdgeInsets.only(bottom: 15),
        color: AppColors.appSecondaryBackgroundColor,
        width: Get.width,
        child: ListView(
          children: [
            Container(
              width: Get.width - 24,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.appBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ACI Tokens',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.59,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            child: PieChart(PieChartData(
                                sections: controller.pieChartSections(),
                                centerSpaceRadius: 50,
                                sectionsSpace: 6
                            )),
                          ),
                          Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Center(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Total Balance', style: TextStyle(color: Colors.white, fontSize: 12),),
                                  SizedBox(height: 5),
                                  Text('${controller.totalToken.value.toPrecision(1)}',
                                    style: TextStyle(color: Colors.white, fontSize: 18),),
                                ],
                              ))),
                        ],
                      ),
                      SizedBox(width: 15,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 10,),
                                  Text('Mining', style: TextStyle(color: Colors.white),),
                                ],),

                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    color: Colors.transparent,
                                  ),
                                  SizedBox(width: 10,),
                                  Text('${controller.miningToken.value.toPrecision(1)} ACI',
                                    style: TextStyle(color: Colors.white,
                                    ),),
                                ],),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 10,),
                                  Text('Quiz', style: TextStyle(color: Colors.white),),
                                ],),


                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    color: Colors.transparent,
                                  ),
                                  SizedBox(width: 10,),
                                  Text('${controller.quizToken.value.toPrecision(1)} ACI',
                                    style: TextStyle(color: Colors.white,
                                    ),),
                                ],),
                            ],
                          ),


                          SizedBox(height: 20,),



                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(width: 10,),
                                  Text('Boost', style: TextStyle(color: Colors.white),),
                                ],),


                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    color: Colors.transparent,
                                  ),
                                  SizedBox(width: 10,),
                                  Text('${controller.boostToken.value.toPrecision(1)} ACI',
                                    style: TextStyle(color: Colors.white,
                                    ),),
                                ],),
                            ],
                          ),



                          SizedBox(height: 20,),



                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(width: 10,),
                                  Text('Referral', style: TextStyle(color: Colors.white),),
                                ],),


                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    color: Colors.transparent,
                                  ),
                                  SizedBox(width: 10,),
                                  Text('${controller.referenceToken.value.toPrecision(1)} ACI',
                                    style: TextStyle(color: Colors.white,
                                    ),),
                                ],),
                            ],
                          ),


                          SizedBox(height: 20,),




                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    color: Colors.cyanAccent,
                                  ),
                                  SizedBox(width: 10,),
                                  Text('Staking', style: TextStyle(color: Colors.white),),
                                ],),


                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    color: Colors.transparent,
                                  ),
                                  SizedBox(width: 10,),
                                  Text('${controller.stackingToken.value.toPrecision(1)} ACI',
                                    style: TextStyle(color: Colors.white,
                                    ),),
                                ],),
                            ],
                          ),

                          SizedBox(height: 20,),

                          PreferenceVisibility(
                            preferenceKey: Pref.miningEnabledStatus,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      color: Colors.purple,
                                    ),
                                    SizedBox(width: 10,),
                                    Text('E. Reward', style: TextStyle(color: Colors.white),),
                                  ],),


                                Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      color: Colors.transparent,
                                    ),
                                    SizedBox(width: 10,),
                                    Text('${controller.extraReward.value.toPrecision(1)} ACI',
                                      style: TextStyle(color: Colors.white,
                                      ),),
                                  ],),
                              ],
                            ),
                          ),

                          Obx(() => controller.isMerchant.value ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20,),

                              PreferenceVisibility(
                                preferenceKey: Pref.miningEnabledStatus,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          color: Colors.brown,
                                        ),
                                        SizedBox(width: 10,),
                                        Text('Merchant', style: TextStyle(color: Colors.white),),
                                      ],),


                                    Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          color: Colors.transparent,
                                        ),
                                        SizedBox(width: 10,),
                                        Text('${controller.marchenToken.value.toPrecision(1)} ACI',
                                          style: TextStyle(color: Colors.white,
                                          ),),
                                      ],),
                                  ],
                                ),
                              ),
                            ],
                          ) : SizedBox.shrink()),

                          SizedBox(height: 20,),
                        ],
                      ),

                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text('New', style: TextStyle(color: Colors.green),),
                      Container()
                    ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialogWithIcon(Icons.notifications_none_outlined, "", "Token transfers will be accessible in Phase 4 after completing the KYC verification process."
                              , "Ok", AppColors.appSecondaryBackgroundColor);
                          /* await showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.all(16.0),
                                    actionsPadding: EdgeInsets.all(16.0),
                                    // Adjust padding as needed

                                    backgroundColor:
                                    AppColors.appBackgroundColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.0)),
                                    title: Text(
                                      "Transfer Coins",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Container(
                                        height: 250,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  'User Id ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Form(
                                              key: controller.userIdFormKey,
                                              // Use a different key for the old password
                                              child: TextFormField(
                                                controller: controller
                                                    .userIdController,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: 'Poppins',
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                                onChanged: (value) {
                                                  controller.userIdFormKey
                                                      .currentState!
                                                      .validate();
                                                  // controller.setAllDataValidated();
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter  UserID";
                                                  }
                                                  // Your validation logic for the old password
                                                },
                                                decoration: InputDecoration(

                                                  hintText: "Enter User id",
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey[400], // Change the color here
                                                  ),
                                                  fillColor: AppColors
                                                      .appTextFieldColor,
                                                  filled: true,
                                                  border:
                                                  OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            12)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.currency_bitcoin,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  'Amount ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Form(
                                              key: controller.AmountFormKey,
                                              // Use a different key for the old password
                                              child: TextFormField(
                                                controller: controller
                                                    .AmountControllertrasfer,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: 'Poppins',
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                                keyboardType:
                                                TextInputType.number,
                                                onChanged: (value) {
                                                  controller.userIdFormKey
                                                      .currentState!
                                                      .validate();
                                                  // controller.setAllDataValidated();
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter Amount ";
                                                  }
                                                  // Your validation logic for the old password
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Enter Amount",
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey[400], // Change the color here
                                                  ),

                                                  fillColor: AppColors
                                                      .appTextFieldColor,
                                                  filled: true,
                                                  border:
                                                  OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            12)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          if (controller.userIdFormKey
                                              .currentState!
                                              .validate() &&
                                              controller.AmountFormKey
                                                  .currentState!
                                                  .validate()) {
                                            controller
                                                .transferCoin(context);
                                            // Navigator.of(context).pop();
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            color: Color(0xff6ACC86),
                                          ),
                                          child: Text(
                                            'Submit',
                                            style: TextStyle(
                                              color: Color(0xFFffffff),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            color: Color(0xff2BA6CE),
                                          ),
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Color(0xFFffffff),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );*/

                          // final action = await Dialogs.generalDialog(context,
                          //     "Token transfers will become accessible during phase 4 following completion of the KYC verification process.");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                            border:
                            Border.all(color: Color(0x99ffFFFF)),
                          ),
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/images/transfer_icon.png'),
                                height: 12,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'Transfer',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.59,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await controller.goToStacking();
                          //   final action = await Dialogs.generalDialog(
                          //       context,
                          //       "ACI token staking will be available once Phase 1 is completed.");
                        },
                        child: Column(
                          children: [
                            ShakeWidget(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  border:
                                  Border.all(color: Color(0x99ffFFFF)),
                                ),
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/stacking_icon.png'),
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      'Staking',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
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
                      PreferenceVisibility(
                        preferenceKey: Pref.isWithdrawEnabled,
                        child: InkWell(
                          onTap: () async {
                            final action = await Dialogs.generalDialog(
                                context,
                                "Once Phase 4 is reached and the KYC verification process is successfully completed, you'll have the opportunity to gracefully withdraw your ACI Tokens.");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              border:
                              Border.all(color: Color(0x99ffFFFF)),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage(
                                      'assets/images/withdraw_icon.png'),
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  'Withdraw',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
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
            PreferenceVisibility(
              preferenceKey: Pref.miningEnabledStatus,
              child: Container(
                width: Get.width - 24,
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.appBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                          () => Text(
                        controller.isMerchant.value ?
                        'Merchant' : 'Extra Reward',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                    Row(children: [
                      Icon(Icons.person_pin_outlined, color: Colors.white,),
                      SizedBox(width: 8,),
                      Obx(
                            () => Text(
                          controller.isMerchant.value ?
                          'Merchant Program' : 'E. Offer Program',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      ),
                      Spacer(),
                      Obx(
                            ()=> Visibility(
                          visible: controller.walletTokenModel.value?.result?.offers?.isNotEmpty ?? false,
                          child: InkWell(
                            onTap: (){
                              Get.to(() => MerchantOffer());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                border:
                                Border.all(color: Color(0x99ffFFFF)),
                              ),
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Icon(
                                    size: 16,
                                    Icons.local_offer_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    'Offers',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
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
                      ),
                      SizedBox(width: 5,),
                      InkWell(
                        onTap: (){
                          Get.to(MerchantHistory());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                            border:
                            Border.all(color: Color(0x99ffFFFF)),
                          ),
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Icon(
                                size: 16,
                                Icons.history_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(width: 2,),
                              Text(
                                'History',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.59,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],),
                  ],
                ),
              ),
            ),
            PreferenceVisibility(
              preferenceKey: Pref.miningEnabledStatus,
              child: Container(
                width: Get.width - 24,
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.appBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Reward Token',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.59,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            Get.to(RewardHistory());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              border:
                              Border.all(color: Color(0x99ffFFFF)),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Icon(
                                  size: 16,
                                  Icons.history_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 2,),
                                Text(
                                  'History',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
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
                    SizedBox(
                      height: 15,
                    ),
                    //Need to change the != to ==
                    if (controller.walletModel.value?.result?.rewardTokens
                        ?.rewardTokens ==
                        0.0) Text(
                        "No Rewarded Token Available. Do mining and play quiz to get.",
                        textAlign: TextAlign.center,
                        // Align the text to the center

                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.59,
                        )) else Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage(
                                  'assets/images/shib_icon.png'),
                              height: 32,
                              width: 32,
                            ),
                            Text(
                              ' SHIB',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.59,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${controller.walletModel.value?.result?.rewardTokens?.rewardTokens}  ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.59,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                // if(controller.walletModel.value!.result!.rewardTokens
                                //     !.rewardTokens! > 20000.0){
                                //   errorSnack("You can't withdraw below 20000");
                                // }

                                await showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      contentPadding:
                                      EdgeInsets.all(16.0),
                                      actionsPadding:
                                      EdgeInsets.all(16.0),
                                      // Adjust padding as needed

                                      backgroundColor: AppColors
                                          .appBackgroundColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10.0)),
                                      title: Text(
                                        "Withdraw shib",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                        ),
                                      ),
                                      content:
                                      SingleChildScrollView(
                                        child: Container(
                                          //  height: Get.height - 200,
                                          child: Obx(
                                                () => Column(
                                              children: [
                                                SizedBox(
                                                  height: 15,
                                                ),

                                                Row(
                                                  children: [
                                                    Text(
                                                      'Select Network:',
                                                      style:
                                                      TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontSize: 15,
                                                        fontFamily:
                                                        'Poppins',
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [

                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Form(
                                                      key: controller
                                                          .walletAddressOrBinanceIDFormKey,
                                                      // Use a different key for the old password
                                                      child: Obx(() {
                                                        return Container(
                                                          width: Get.width *
                                                              0.70,
                                                          // Adjust the width here

                                                          child: DropdownButtonFormField<
                                                              String>(
                                                            value: controller
                                                                .SelectedwalletAddressOrBinanceID
                                                                .value,
                                                            dropdownColor:
                                                            AppColors
                                                                .appTextFieldColor,

                                                            items: controller
                                                                .addressOrBenificial
                                                                .map((String
                                                            network) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value:
                                                                network,
                                                                child: Text(
                                                                  network,
                                                                  style:
                                                                  TextStyle(
                                                                    color: Colors
                                                                        .white, // Set text color to white
                                                                  ),
                                                                ),
                                                              );
                                                            }).toList(),
                                                            onChanged:
                                                                (String?
                                                            value) {
                                                              controller
                                                                  .SelectedwalletAddressOrBinanceID
                                                                  .value =
                                                              value!;

                                                              if (value !=
                                                                  "BinanceId") {
                                                                controller
                                                                    .selectedKey
                                                                    .value =
                                                                "walletAddress";


                                                                controller
                                                                    .hintText
                                                                    .value =
                                                                "Please Enter Wallet Address";
                                                              } else {
                                                                controller
                                                                    .selectedKey
                                                                    .value =
                                                                "binanceId";

                                                                controller
                                                                    .hintText
                                                                    .value =
                                                                "Please Enter Binance ID";
                                                              }
                                                            },
                                                            validator:
                                                                (value) {
                                                              if (value ==
                                                                  null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Please select a wallet network';
                                                              }
                                                              // Your validation logic here if needed
                                                              return null;
                                                            },
                                                            decoration:
                                                            InputDecoration(
                                                              fillColor:
                                                              AppColors
                                                                  .appTextFieldColor,
                                                              filled: true,
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                                    Radius
                                                                        .circular(
                                                                        12)),
                                                              ),

                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Address or BinanceID:',
                                                      style:
                                                      TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontSize: 15,
                                                        fontFamily:
                                                        'Poppins',
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Obx(() =>
                                                    Form(
                                                      key: controller
                                                          .binanceIdFormKey,
                                                      // Use a different key for the old password
                                                      child:
                                                      TextFormField(
                                                        controller: controller
                                                            .walletAddressOrbinanceIdController,
                                                        style: TextStyle(
                                                          color: Colors
                                                              .white,
                                                          fontSize: 15,
                                                          fontFamily:
                                                          'Poppins',
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                        ),
                                                        maxLength: controller
                                                            .selectedKey
                                                            .value ==
                                                            "binanceId"
                                                            ? 15
                                                            : 100,
                                                        keyboardType: controller
                                                            .selectedKey
                                                            .value ==
                                                            "binanceId"
                                                            ? TextInputType
                                                            .number
                                                            :
                                                        TextInputType
                                                            .name,
                                                        onChanged:
                                                            (value) {},
                                                        validator:
                                                            (value) {
                                                          if (value!
                                                              .isEmpty) {
                                                            return "Please enter wallet Address/ BinanceID ";
                                                          }
                                                          // Your validation logic for the old password
                                                        },
                                                        decoration:
                                                        InputDecoration(
                                                          hintText: controller
                                                              .hintText.value,
                                                          hintStyle: TextStyle(
                                                            color: Colors
                                                                .grey[400], // Change the color here
                                                          ),
                                                          fillColor: AppColors
                                                              .appTextFieldColor,
                                                          filled: true,
                                                          border:
                                                          OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.all(
                                                                Radius
                                                                    .circular(
                                                                    12)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),),

                                                SizedBox(
                                                  height: 10,
                                                ),

                                                Row(
                                                  children: [
                                                    Text(
                                                      'Amount :(${controller
                                                          .walletModel.value
                                                          ?.result
                                                          ?.rewardTokens
                                                          ?.rewardTokens} )',
                                                      style:
                                                      TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontSize: 15,
                                                        fontFamily:
                                                        'Poppins',
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Form(
                                                  key: controller
                                                      .AmountFormKey,
                                                  // Use a different key for the old password
                                                  child:
                                                  TextFormField(
                                                    controller: controller
                                                        .AmountController,
                                                    style: TextStyle(
                                                      color: Colors
                                                          .white,
                                                      fontSize: 15,
                                                      fontFamily:
                                                      'Poppins',
                                                      fontWeight:
                                                      FontWeight
                                                          .w500,
                                                    ),
                                                    keyboardType:
                                                    TextInputType
                                                        .number,
                                                    onChanged:
                                                        (value) {
                                                      // controller.setAllDataValidated();
                                                    },
                                                    validator:
                                                        (value) {
                                                      if (value!
                                                          .isEmpty) {
                                                        return "Please enter Amount ";
                                                      }
                                                      // Your validation logic for the old password
                                                    },
                                                    decoration:
                                                    InputDecoration(
                                                      hintText: "Please Enter Amount",
                                                      hintStyle: TextStyle(
                                                        color: Colors
                                                            .grey[400], // Change the color here
                                                      ),
                                                      fillColor: AppColors
                                                          .appTextFieldColor,
                                                      filled: true,
                                                      border:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 5,
                                                ),
                                                controller
                                                    .SelectedwalletAddressOrBinanceID
                                                    .value != 'BinanceId' ? Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Fee: ${controller.withdrawSetup.value?.withDrawFeeInShib ?? "7500"}", style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0
                                                    ),
                                                    ),
                                                  ],
                                                ) : Container(),
                                                SizedBox(height: 5,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("•Min Amount: ${controller.withdrawSetup.value?.minWithdrawLimit ?? "20000"}", style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 16.0
                                                    ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("•Max Amount: ${controller.withdrawSetup.value?.maxWithdrawLimit ?? "50000"}", style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 16.0
                                                    ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        if (controller.withdrawSetup.value?.isButtonVisible ?? false)
                                          InkWell(
                                            onTap: () {

                                              if (controller.walletAddressOrBinanceIDFormKey.currentState!.validate() &&
                                                  controller
                                                      .binanceIdFormKey
                                                      .currentState!
                                                      .validate() &&
                                                  controller
                                                      .AmountFormKey
                                                      .currentState!
                                                      .validate()) {


                                                if(controller.selectedKey.value=="binanceId")
                                                {
                                                  final RegExp numberRegex = RegExp(r'^[0-9]+$');
                                                  var value=controller.walletAddressOrbinanceIdController.text;
                                                  if (!numberRegex.hasMatch(value)) {

                                                    errorSnack("Please enter a valid binanceId");
                                                  }
                                                }

                                                if ((controller.walletModel.value?.result?.rewardTokens?.rewardTokens ?? 0.0) < double.parse(controller.AmountController.text)) {
                                                  showDialogWithIcon(Icons.notifications_none_outlined, "", "You have not enough token to continue withdraw.\nPlease try again later."
                                                      , "OK", AppColors.appSecondaryBackgroundColor);
                                                } else {
                                                  showProceedDialogWithIcon(Icons.notifications_none_outlined, "", "Confirm your address or ID carefully.\nOrbaic is not responsible for incorrect withdrawals, and blockchain transactions are irreversible. No refunds."
                                                      , AppColors.appSecondaryBackgroundColor, () {
                                                        controller
                                                            .withdrawShib(
                                                            context);

                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                }
                                              }
                                            },
                                            child: Container(
                                              padding:
                                              EdgeInsets.all(10),
                                              decoration:
                                              BoxDecoration(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius
                                                        .circular(
                                                        25)),
                                                //      color: Color(0xff6ACC86),
                                              ),
                                              // child: Text(
                                              //   'Opening Soon',
                                              //   style: TextStyle(
                                              //     color: Color(
                                              //         0xFFffffff),
                                              //   ),
                                              // ),
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.all(Radius.circular(25)),

                                                ),
                                                child: Text(
                                                  'Submit',
                                                  style: TextStyle(
                                                    color: Color(
                                                        0xFFffffff),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        InkWell(
                                          onTap: () async {
                                            Navigator.of(context)
                                                .pop();
                                          },
                                          child: Container(
                                            padding:
                                            EdgeInsets.all(10),
                                            decoration:
                                            BoxDecoration(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius
                                                      .circular(
                                                      25)),
                                              color:
                                              Color(0xff2BA6CE),
                                            ),
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                color: Color(
                                                    0xFFffffff),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                // final action = await Dialogs.generalDialog(context,
                                //     "You'll be eligible to withdraw once your Shib balance reaches 20K. Withdrawals will open promptly upon notification by Orbaic.");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                      color: Color(0x99ffFFFF)),
                                ),
                                padding: EdgeInsets.only(
                                    left: 7,
                                    bottom: 7,
                                    right: 7,
                                    top: 7),
                                child: Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/withdraw_icon.png'),
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Withdraw',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Get.width / 2 - 18,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.appBackgroundColor,
                      borderRadius:
                      BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Quiz Summary',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.59,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator(
                          // value: controller.walletModel.value?.result
                          //     ?.quizSummary?.quizSeasonProgress,
                          value: (controller.walletModel.value?.result?.quizSummary?.totalSolvedQuiz ?? 0) /
                              (controller.walletModel.value?.result?.quizSummary?.quizSeason ?? 1800),
                          color: Color(0xffFF6543),
                          backgroundColor: Color(0xffF2F4F7),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${controller.walletModel.value?.result?.quizSummary?.totalSolvedQuiz ?? 0}/'
                              '${controller.walletModel.value?.result?.quizSummary?.quizSeason ?? 1800}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width / 2 - 18,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.appBackgroundColor,
                      borderRadius:
                      BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Mining Hours',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.59,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator(
                          value: controller.walletModel.value?.result
                              ?.miningSummary?.sessionProgress ?? 0,
                          // Use controller method here
                          color: Color(0xff64D2FF),
                          backgroundColor: Color(0xffF2F4F7),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${(controller.walletModel.value?.result?.miningSummary?.miningHours ?? 0) % 2160}/${controller.walletModel.value?.result?.miningSummary?.summaryHours ?? 2160}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),

    ));
  }
}