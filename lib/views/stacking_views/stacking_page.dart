import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_from_practice_widget/views/stacking_views/stacking_faq_page.dart';
import 'package:project_from_practice_widget/views/stacking_views/stacking_history_page.dart';

import '../../ads/AdManager.dart';
import '../../colors/app_colors.dart';
import '../../controllers/stacking_controller.dart';

class StackingPage extends StatelessWidget {
  StackingPage({super.key});
  final StackingController controller = Get.put(StackingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Staking',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.59,
          ),
        ),
        actions: [
          InkWell(
            onTap: (){
              Get.to(() => StackingFAQPage());
            },
            child: Row(children: [
              Icon(Icons.quiz, color: Colors.white,),
              SizedBox(width: 5,),
              Text('FAQ', style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.59,
              ),),
              SizedBox(width: 15,),
            ],),
          ),
        ],
      ),
      body: Container(
        color: AppColors.appSecondaryBackgroundColor,
        child: ListView(
          children: [
            Container(
              width: Get.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                    width: Get.width * 0.70 - 24,
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.appBackgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total ACI Token',
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
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/images/colored_logo.png'),
                                height: 30,
                                width: 30,
                              ),
                              Obx(
                                    () => Text(
                                  'ACI ${controller.totalAciTokensMiningAndQuiz.value.toPrecision(1) ?? ""}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.59,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Text(
                                'Mining & quiz',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.59,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/images/colored_logo.png'),
                                height: 30,
                                width: 30,
                              ),
                              Obx(
                                    () => Text(
                                  'ACI ${controller.totalAciTokensReferralAndBoost.value.toPrecision(1)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.59,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Text(
                                'Ref & Boost',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.59,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 140,
                    width: Get.width * 0.30 - 12,
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.appBackgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Staking',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.59,
                          ),
                        ),
                        SizedBox(height: 25,),
                        InkWell(
                          onTap: (){
                            Get.to(() => StackingHistoryPage());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              border:
                              Border.all(color: Color(0x99ffFFFF)),
                            ),
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.history_outlined,
                                  color: Colors.white,
                                ),
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
                  ),
                ],
              ),
            ),
            Container(
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
                  Text(
                    'Choose Which Wallet to Stake from',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.59,
                    ),
                  ),

                  SizedBox(height: 8,),
                  Row(
                      children: [
                        Row(
                          children: [
                            Obx( () => Radio(
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: true,
                              groupValue: controller.isLookUpFromMain.value,
                              onChanged: (bool? value) {
                                controller.isLookUpFromMain.value = value!;
                                print(controller.isLookUpFromMain.value);
                              },
                            ),
                            ),
                            Text('Mining & Quiz', style: TextStyle(color: Colors.white),),

                          ],
                        ),
                        SizedBox(width: 12.0,),
                        Row(
                          children: [
                            Obx(
                                  () => Radio(
                                visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: false,
                                groupValue: controller.isLookUpFromMain.value,
                                onChanged: (bool? value) {
                                  controller.isLookUpFromMain.value = value!;
                                  print(controller.isLookUpFromMain.value);
                                },
                              ),
                            ),
                            Text('Referral & Boost', style: TextStyle(color: Colors.white)),

                          ],
                        )]),
                  SizedBox(height: 17,),

                  Text(
                    'Adjust Lockup rate & Duration',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.59,
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lockup rate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.59,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0x1affffff),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Obx(
                              () => Text(
                            '${controller.lookUpRate.value.floor()}%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.59,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() => Slider(value: controller.lookUpRate.value, onChanged: (value){
                    controller.lookUpRate.value = value;
                  }, max: 100, min: 1, divisions: 99,)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('1    ', style: TextStyle(color: Colors.white),),
                        Text('    50', style: TextStyle(color: Colors.white),),
                        Text('   100', style: TextStyle(color: Colors.white),)
                      ],),
                  ),
                  SizedBox(height: 10,),
                  Divider(),
                  SizedBox(height: 10,),
                  Text(
                    'Duration in Years',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.59,
                    ),
                  ),
                  SizedBox(height: 5),
                  Obx(() => Slider(value: controller.duration.value.toDouble(), onChanged: (value){
                    controller.duration.value = (value).toInt() ;
                    print(controller.duration.value);
                  }, max: 4, min: 1, divisions: 3,)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('1', style: TextStyle(color: Colors.white),),
                        Text('2', style: TextStyle(color: Colors.white),),
                        Text('3', style: TextStyle(color: Colors.white),),
                        Text('4', style: TextStyle(color: Colors.white),),
                      ],),
                  ),

                  /*
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0x1affffff),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: SizedBox(
                          width: 40,
                          child: Center(
                            child: Obx(
                              () => Text(
                                '${controller.duration.value}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.59,
                                ),

                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        InkWell(
                          onTap: (){
                            if(controller.duration.value < 5){
                              controller.duration.value++;
                            }
                          },
                            child: Icon(Icons.arrow_circle_up_outlined, size: 32, color: Colors.teal,)
                        ),
                        SizedBox(height: 4,),
                        InkWell(
                            onTap: (){
                              if(controller.duration.value > 1){
                                controller.duration.value--;
                              }
                            },
                            child: Icon(Icons.arrow_circle_down_outlined, size: 32, color: Colors.teal))
                      ],),
                      SizedBox(width: 8,),

                    ],
                  ),*/
                  SizedBox(height: 10,),
                  Divider(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image(height: 30, width: 30,image: AssetImage('assets/images/final_lockup.png')),
                          SizedBox(width: 5,),
                          Text('Final Lockup', style: TextStyle(color: Colors.white),)
                        ],
                      ),
                      Obx(() => controller.isLookUpFromMain.value ?
                      Text('${( controller.totalAciTokensMiningAndQuiz *
                          controller.lookUpRate.value / 100.0).toPrecision(5)}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),) :
                      Text('${( controller.totalAciTokensReferralAndBoost *
                          controller.lookUpRate.value / 100.0).toPrecision(5)}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),

                    ],),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image(height: 30, width: 30,image: AssetImage('assets/images/estimated_return.png')),
                          SizedBox(width: 5,),
                          Text('Estimated Return', style: TextStyle(color: Colors.white),)
                        ],
                      ),
                      Obx( () => Text( controller.duration.value == 1 ? '130%' :
                      controller.duration.value == 2 ? '150%' :
                      controller.duration.value == 3 ? '180%' :
                      controller.duration.value == 4 ? '200%' :
                      controller.duration.value == 5 ? '250%' : "Null", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),

                    ],),
                ],
              ),
            ),
            SizedBox(height: 15,),
            InkWell(
              onTap: () async {
                bool isAdReady =
                await AdManager.instance.isAdReady();
                if (isAdReady) {
                  await AdManager.instance.showAd();
                }
                await controller.doStacking();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                padding: EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15),
                // margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.appSecondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Center(
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
              ),
            ),
            // SizedBox(height: 100,),
            // InkWell(
            //   onTap: () async {
            //     Get.to(() => StackingFAQPage());
            //   },
            //   child: Container(
            //     margin: EdgeInsets.symmetric(horizontal: 50),
            //     padding: EdgeInsets.symmetric(
            //         horizontal: 30, vertical: 15),
            //     // margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            //     decoration: BoxDecoration(
            //       color: Colors.greenAccent,
            //       borderRadius: BorderRadius.all(Radius.circular(15)),
            //     ),
            //     child: Center(
            //       child: Text(
            //         'FAQ',
            //         textAlign: TextAlign.right,
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 13,
            //           fontFamily: 'Poppins',
            //           fontWeight: FontWeight.w500,
            //           letterSpacing: 0.59,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}