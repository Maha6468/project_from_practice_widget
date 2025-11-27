import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../colors/app_colors.dart';
import '../../controllers/merchant_controller.dart';

class MerchantHistory extends StatelessWidget {
  final MerchantController controller = Get.put(MerchantController());

  MerchantHistory({super.key});
  @override
  Widget build(BuildContext context) {
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
              'History',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.59,
              ),
            ),
          ),
          body: controller.historyModel.value == null || controller.historyModel.value!.result!.content!.isEmpty ?
          Center(
            child: Text('There is no offer history in your account.',
              style: TextStyle(color: Colors.white, fontSize: 18),textAlign: TextAlign.center,),
          ) :
          Obx(
                () => ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 6),
              itemCount: controller.historyModel.value?.result?.content?.length,
              itemBuilder: (context, index){
                DateTime createdDateTemp = DateTime.fromMillisecondsSinceEpoch(controller.historyModel.value!.result!.content![index].createdAt!, isUtc: true);
                DateTime createdDate = DateTime(createdDateTemp.year, createdDateTemp.month, createdDateTemp.day);
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
                              '${(controller.historyModel.value?.result!.content![index].token ?? 0.0).toPrecision(1)}',
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
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.timelapse_outlined, color: Color(0x80ffffff),),
                        SizedBox(width: 5,),
                        Text(
                          'Released: ${DateFormat('dd-MM-yyyy').format(createdDate)}',
                          style: TextStyle(
                            color: Color(0x80ffffff),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.59,
                          ),
                        ),
                        SizedBox(width: 5,),
                      ],
                    ),

                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.bloodtype_outlined, color: Color(0x80ffffff),),
                        SizedBox(width: 5,),
                        Text(
                          'Type: ${controller.historyModel.value?.result!.content![index].type}',
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
                          'Description: ${controller.historyModel.value?.result!.content![index].description}',
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
}