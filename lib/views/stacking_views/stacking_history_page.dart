import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../colors/app_colors.dart';
import '../../controllers/stacking_controller.dart';

class StackingHistoryPage extends StatelessWidget {
  StackingHistoryPage({super.key});
  final StackingController controller = Get.find();
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
      body: FutureBuilder(
          future: controller.stackHistory(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: Container());
            }

            else if(snapshot.data!.isEmpty){
              return Center(
                child: Text('There is no staking history in your account.',
                  style: TextStyle(color: Colors.white, fontSize: 18),),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 6),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                DateTime createdDateTemp = DateTime.fromMillisecondsSinceEpoch(snapshot.data![index].createdAt!, isUtc: true);
                DateTime releaseDateTemp = DateTime.fromMillisecondsSinceEpoch(snapshot.data![index].expireDuration!, isUtc: true);
                DateTime createdDate = DateTime(createdDateTemp.year, createdDateTemp.month, createdDateTemp.day);
                DateTime releaseDate = DateTime(releaseDateTemp.year, createdDateTemp.month, createdDateTemp.day);

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
                          'Total Lockup',
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
                              '${(snapshot.data![index].aciTokensInStack ?? 0.0).toPrecision(1)}',
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
                        Visibility(
                          visible: snapshot.data![index].claimable!,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Color(0xff6ACC86),
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Text('Release', style: TextStyle(
                              color: Colors.black,
                            ),),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Total Ratio',
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
                            Text(
                              '${snapshot.data![index].durationInYears == 1 ? 130 :
                              snapshot.data![index].durationInYears == 2 ? 150 :
                              snapshot.data![index].durationInYears == 3 ? 180 : 200}%',
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
                        Text(
                          'Total Return',
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
                              '${((snapshot.data![index].profit! + snapshot.data![index].aciTokensInStack!).toPrecision(1)?? 0.0).toPrecision(1)}',
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
                          'Created: ${DateFormat('dd-MM-yyyy').format(createdDate)}',
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
                            'Release: ${DateFormat('dd-MM-yyyy').format(releaseDate)}',
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
                        Icon(Icons.access_time, color: Color(0x80ffffff),),
                        SizedBox(width: 5,),
                        Text(
                          'Duration ${snapshot.data![index].durationInYears} years',
                          style: TextStyle(
                            color: Color(0x80ffffff),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.59,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Icon(Icons.lock_reset_rounded, color: Color(0x80ffffff)),
                        SizedBox(width: 5,),
                        Expanded(
                          child: Text(
                            'Lockup from: ${snapshot.data![index].stackType}',
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
                    SizedBox(height: 10,),
                  ],),
                );
              },
            );
          }
      ),
    );
  }
}