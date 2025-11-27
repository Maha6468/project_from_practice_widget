import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dialogs.dart';

class ClaimShibaInuButton extends StatelessWidget {
  const ClaimShibaInuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final action = await Dialogs.generalDialog(context,
            "successfully_collected".tr
        );

      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        decoration: BoxDecoration(
          color: Color(0xff64D2FF),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          'claim_shiba_inu'.tr,
          style: TextStyle(
            color: Color(0xFF212D40),
            fontSize: 13.11,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 1.07,
          ),
        ),
      ),
    );
  }
}