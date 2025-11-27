import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_from_practice_widget/views/widgets/shake_widget.dart';

import '../../controllers/home_page_controller.dart';
import '../quiz_views/quize_home_page.dart';
import 'dialogs.dart';

class QuizAvailable extends StatelessWidget {
  QuizAvailable({super.key});
  HomePageController controller = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (controller.isMinings.isFalse && controller.isMiningEnabled.isTrue) {
          FeatureDiscovery.discoverFeatures(
            context,
            const <String>{'feature1'},
          );
        }
        else {
          Get.to(() => QuizHomePage());
        }
      },
      child: SingleChildScrollView(
        scrollDirection:
        Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 25,),
            Text(
              'quiz_available'.tr,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6000000238418579),
                fontSize: 13.11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                letterSpacing: 1.07,
              ),
            ),
            SizedBox(width: 12,),
            ShakeWidget(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                decoration: BoxDecoration(
                  color: Color(0xff64D2FF),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  'start_now'.tr,
                  style: TextStyle(
                    color: Color(0xFF212D40),
                    fontSize: 13.11,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.07,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}