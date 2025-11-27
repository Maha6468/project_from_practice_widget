import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors/app_colors.dart';
import '../../controllers/get_all_teammermber_controller.dart';
import '../../models/all_team_model.dart';
import '../widgets/dialogs.dart';


class GetAllTeamMembersPage extends StatelessWidget {
  GetAllTeamMembersPage({Key? key}) : super(key: key);

  final GetALLTeamController controller = Get.put(GetALLTeamController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appSecondaryColor,
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image(
              image: AssetImage('assets/images/appbar_back_arrow.png'),
              height: 32,
              width: 32,
            ),
          ),
        ),
        title:
        Obx(() {
          return Text(controller.allTeamModel.value == null ? 'No referred users' :
          'Team Members (${controller.allTeamModel.value?.result?.teamMembers?.length ?? 0})',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.59,
            ),
          );
        }),
        actions: [
          InkWell(
            onTap: () async {
              final action = await Dialogs.generalDialog(
                context,
                "We're currently working on this section. Once it's available, we'll notify you through the notice portal.",
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.speaker_notes, color: Colors.white),
            ),
          )
        ],
      ),
      body: Obx(() =>
          Container(
            width: Get.width,
            color: AppColors.appSecondaryBackgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 12),
            child:

            controller.allTeamModel.value == null
                ? Container(
                width: Get.width,
                height: Get.height,

                child: Center(child: Text('No referred users',    style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.59,
                )))):

            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.appBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          color: Color(0x4DFF6543),
                        ),
                        child: Center(
                          child: Obx(() {
                            int inactiveMembers = controller
                                .allTeamModel.value?.result?.teamMembers
                                ?.where((member) => member.isMining == false)
                                .length ??
                                0;

                            return Text(
                              ' $inactiveMembers',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFFF6442),
                                fontSize: 17,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.85,
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Text(
                        'Inactive Members',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.65,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          controller.pingAllMembers();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.appSecondaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.access_time_filled,
                                  color: Color(0xffffffff)),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'Ping Them',
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: Color(0x1AFFFFFF),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xff41918B),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Icon(
                          Icons.search_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: Get.width - 120,
                        padding: EdgeInsets.only(right: 12),
                        child: TextField(
                          onChanged: (value) {
                            controller.searchQuery.value = value;
                          },
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.65,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            hintText: "search",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.65,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.isTrue) {
                      return Center(child: CircularProgressIndicator());
                    }
                    // else if (  controller.teamMembers.isEmpty) {
                    //   var data=  controller.teamMembers;
                    //   print ("statusss");
                    //   print (data);
                    //   return Center(
                    //     child: Text(
                    //       'No referred users',
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 18,
                    //         fontFamily: 'Poppins',
                    //         fontWeight: FontWeight.w600,
                    //         letterSpacing: 0.59,
                    //       ),
                    //     ),
                    //   );
                    // }
                    else {
                      final filteredMembers = controller.filteredTeamMembers;
                      if (filteredMembers.isEmpty) {
                        return Center(
                          child: Text(
                            'No Data Found',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.59,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: filteredMembers.length,
                          itemBuilder: (context, index) {
                            TeamMember member = filteredMembers[index];
                            print("Sakib checking Team Member ${member.toJson()}");
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.appBackgroundColor,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image(
                                      height: 32,
                                      width: 32,
                                      image: AssetImage('assets/images/avatar.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    member.fullname ?? "",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.59,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: ShapeDecoration(
                                      color: member.isMining == false
                                          ? Color(0x1A61C7C4)
                                          : Color(0xFF61C7C4),
                                      shape: OvalBorder(),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    }
                  }),
                ),
              ],
            ),
          )),
    );
  }
}