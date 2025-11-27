import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../colors/app_colors.dart';
import '../../controllers/reward_history_controller.dart';


class RewardHistory extends StatelessWidget {
  final RewardHistoryController controller = Get.put(RewardHistoryController());

  RewardHistory({super.key});

  GlobalKey repaintKey = GlobalKey();

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
      body: Obx(() => controller.historyModel.value == null || (controller.historyModel.value?.result ?? []).isEmpty ?
      Center(
        child: Text('There is no withdraw history in your account.',
          style: TextStyle(color: Colors.white, fontSize: 18),textAlign: TextAlign.center,),
      ) :
      Obx(
            () {
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 6),
            itemCount: controller.historyModel.value?.result?.length ?? 0,
            itemBuilder: (context, index){
              DateTime createdDateTemp = DateTime.fromMillisecondsSinceEpoch(controller.historyModel.value!.result![index].createAt!, isUtc: true);
              DateTime createdDate = DateTime(createdDateTemp.year, createdDateTemp.month, createdDateTemp.day);
              double fees = (controller.historyModel.value!.result![index].amount ?? 0.0) - (controller.historyModel.value?.result![index].finalAmount ?? 0.0);
              return Container(
                margin: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.appBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${controller.historyModel.value?.result![index].wallet == "BinanceId" ? "Binance" : controller.historyModel.value?.result![index].wallet}',
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
                            // Image(
                            //   image: AssetImage(
                            //       'assets/images/colored_logo.png'),
                            //   height: 24,
                            //   width: 24,
                            // ),
                            Text(
                              'Status:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.59,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${controller.historyModel.value?.result![index].status}',
                              style: TextStyle(
                                color: _getStatusColor(controller.historyModel.value?.result![index].status ?? ""),
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
                          onTap: () {
                            controller.createAndShareImage(controller.historyModel.value?.result![index]);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(Icons.share, color: Colors.white, size: 20,),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    _buildIfoItem(
                      icon: Icons.add_chart,
                      title: "Total Withdrawal",
                      value: controller.historyModel.value?.result![index].amount,
                    ),
                    _buildIfoItem(
                      icon: Icons.feed_outlined,
                      title: "Fees",
                      value: fees.abs(),
                    ),
                    _buildIfoItem(
                      icon: Icons.feed_outlined,
                      title: "Actual Received",
                      value: controller.historyModel.value?.result![index].finalAmount,
                    ),
                    _buildIfoItem(
                      icon: Icons.bloodtype_outlined,
                      title: "Type",
                      value: controller.historyModel.value?.result![index].type,
                    ),
                    _buildIfoItem(
                      icon: Icons.timelapse_outlined,
                      title: "Released",
                      value: DateFormat('dd-MM-yyyy').format(createdDate),
                    ),
                    // _buildIfoItem(
                    //   icon: Icons.account_tree_rounded,
                    //   title: "Reference ID",
                    //   value: controller.historyModel.value?.result![index].id,
                    // ),
                    if (controller.historyModel.value?.result![index].transaction != null)
                      _buildIfoItem(
                        icon: Icons.description_outlined,
                        title: "Hash ID",
                        value: controller.historyModel.value?.result![index].transaction ?? "",
                      ),
                    if (controller.historyModel.value?.result![index].notes != null)
                      _buildIfoItem(
                        icon: Icons.description_outlined,
                        title: "Note",
                        value: controller.historyModel.value?.result![index].notes ?? "",
                      ),
                  ],),
              );
            },
          );
        },
      )),
    );
  }

  _buildIfoItem({icon, title, value}) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Color(0x80ffffff),),
            SizedBox(width: 5,),
            Expanded(child: Text(
              '$title: $value',
              style: TextStyle(
                color: Color(0x80ffffff),
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.59,
              ),
            )),
          ],
        ),
        SizedBox(height: 10,),
      ],
    );
  }

  Color _getStatusColor(String status) {
    return switch(status.toLowerCase()) {
      "approved" => Colors.green,
      "rejected" => Colors.red,
      "pending" => Colors.white,
      String() => Colors.white,
    };
  }
}