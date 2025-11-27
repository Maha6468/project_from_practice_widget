import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../../ads/AdManager.dart';
import '../../colors/app_colors.dart';
import '../../controllers/merchant_controller.dart';
import 'merchant_history.dart';

class MerchantOffer extends StatelessWidget {
  MerchantOffer({super.key});
  final MerchantController controller = Get.put(MerchantController());
  late InterstitialAd interstitialAd;
  bool isAdLoaded = false;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initAd();
    });
    return Obx(
          () => Scaffold(
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
              'Offers',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.59,
              ),
            ),
          ),
          body: controller.offersModel.value == null || controller.offersModel.value!.result!.content!.isEmpty ?
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('There is no offers in your account.',
                  style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center,),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    Get.to(() => MerchantHistory());
                  },
                  child: Container(
                    width: Get.width / 2,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.appSecondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: Text(
                        'Offer History',
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
              ],

            ),
          ) :
          Obx(
                () => ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 6),
              itemCount: controller.offersModel.value?.result?.content?.length,
              itemBuilder: (context, index){
                DateTime createdDateTemp = DateTime.fromMillisecondsSinceEpoch(controller.offersModel.value!.result!.content![index].createdAt!, isUtc: true);
                DateTime releaseDateTemp = DateTime.fromMillisecondsSinceEpoch(controller.offersModel.value!.result!.content![index].expireAt!, isUtc: true);
                DateTime createdDate = DateTime(createdDateTemp.year, createdDateTemp.month, createdDateTemp.day);
                DateTime releaseDate = DateTime(releaseDateTemp.year, releaseDateTemp.month, releaseDateTemp.day);
                return Container(
                  width: Get.width - 24,
                  margin: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.appBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                          'Offer Token',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.59,
                          ),
                        ),
                        SizedBox(width: 16,),
                        Row(
                          children: [
                            Image(
                              image: AssetImage(
                                  'assets/images/colored_logo.png'),
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(width: 2,),
                            Text(
                              '${(controller.offersModel.value?.result!.content![index].token ?? 0.0).toPrecision(1)}',
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
                        Spacer(),
                        InkWell(
                          onTap: () async {

                            await controller.claimOffer(controller.offersModel.value!.result!.content![index].id!);
                            await controller.onInit();
                            bool isAdReady = await AdManager.instance.isAdReady();
                            if (isAdReady) {
                              await AdManager.instance.showAd();
                            }
                            // if(isAdLoaded){
                            //  await interstitialAd.show();
                            //  await initAd();
                            // }
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Color(0xff6ACC86),
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Text('Claim', style: TextStyle(
                              color: Colors.black,
                            ),),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.timelapse_outlined, color: Color(0x80ffffff),),
                        SizedBox(width: 5,),
                        Text(
                          'Release: ${DateFormat('dd-MM-yyyy').format(createdDate)}',
                          style: TextStyle(
                            color: Color(0x80ffffff),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.59,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Icon(Icons.timer_outlined, color: Color(0x80ffffff)),
                        SizedBox(width: 5,),
                        Expanded(
                          child: Text(
                            'Expire: ${DateFormat('dd-MM-yyyy').format(releaseDate)}',
                            style: TextStyle(
                              color: Color(0x80ffffff),
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.59,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.bloodtype_outlined, color: Color(0x80ffffff),),
                        SizedBox(width: 5,),
                        Text(
                          'Type: ${controller.offersModel.value?.result!.content![index].type}',
                          style: TextStyle(
                            color: Color(0x80ffffff),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.59,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.description_outlined, color: Color(0x80ffffff),),
                        SizedBox(width: 5,),
                        Text(
                          'Description: ${controller.offersModel.value?.result!.content![index].description}',
                          style: TextStyle(
                            color: Color(0x80ffffff),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.59,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                  ],),
                );
              },
            ),
          )
      ),
    );
  }


  Future<void> initAd() async {
    await InterstitialAd.load(
      /* Real Ad Unit Id */
        adUnitId: "ca-app-pub-9323045181924630/7438005611",
        /* Real Ad Unit Id */

        /* Test Ad Unit Id */
        // adUnitId: "ca-app-pub-3940256099942544/1033173712",

        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          //  ad.show();
          interstitialAd = ad;
          isAdLoaded = true;
          print("Sakib load ad");
          //  controller.isAdLoaded.value = true;
          interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) async {
                print("Sakib Dismiss ad");
                await interstitialAd.dispose();
              }, onAdFailedToShowFullScreenContent: (ad, err) async {
            await interstitialAd.dispose();
            print("SAKIBHOSSAINSKB: $err");
            await initAd();
          });
        }, onAdFailedToLoad: (err) async {
          print("SakibSakibSakib: $err");
          await interstitialAd.dispose();
          // controller.isAdLoaded.value = false;
          isAdLoaded = false;
          await initAd();
        }));
  }

}