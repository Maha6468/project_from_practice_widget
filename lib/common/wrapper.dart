import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../colors/app_colors.dart';
import '../main.dart';
import '../main.dart' as AppString;

class NoInternet extends StatefulWidget {
  const NoInternet({
    super.key,
  });

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.black.withOpacity(0.2),
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                InkWell(
                    onTap: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool(AppString.cancelWrapper as String, true);           //maha
                      await Restart.restartApp();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.close, color: Colors.white,),
                    )),
              ],
            ),
            ClipPath(
              clipper: CurveClipper(),
              child: Container(
                height: Get.height * 0.45,
                width: Get.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.04, -1.00),
                    end: Alignment(0.04, 1),
                    colors: [Color(0xFFDA2D3F), Color(0xFFB1021B)],
                  ),
                  color: AppColors.appColor,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset('assets/images/no_internet.json', width: 180),
                  Padding(
                    padding: EdgeInsets.only(bottom: Get.height * 0.02),
                    child: Text(
                      "No Internet",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Get.height * 0.02,
                        right: Get.height * 0.02,
                        bottom: Get.height * 0.05),
                    child: Text(
                      "You are not connected to the internet Make sure Wi-Fi is on, Flight mode is off and try again.",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 60); // Start at the top-left corner
    path.quadraticBezierTo(
        size.width / 2, 0, size.width, 60); // Define a quadratic curve
    path.lineTo(size.width,
        size.height); // Draw a straight line to the bottom-right corner
    path.lineTo(
        0, size.height); // Draw a straight line to the bottom-left corner
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}