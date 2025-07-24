import 'package:flutter/material.dart';
import 'package:project_from_practice_widget/customWidget/custom_Textbutton.dart';
import 'package:project_from_practice_widget/customWidget/cus_AppBar.dart';

class WhatsApp extends StatefulWidget {
  const WhatsApp({super.key});

  @override
  State<WhatsApp> createState() => _WhatsAppState();
}

class _WhatsAppState extends State<WhatsApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        height: double.infinity,width: double.infinity,
        color: Colors.black87,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  First_Co_Ro(text: 'All',  ),
                  First_Co_Ro(text: 'Unread', ),
                  First_Co_Ro(text: 'Favorites',  ),
                  First_Co_Ro(text: 'Groups',  ),
                  First_Co_Ro(text: '+', ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
