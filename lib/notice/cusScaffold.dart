import 'package:flutter/material.dart';
import 'package:project_from_practice_widget/notice/nCustom/cus_AppBar.dart';

class MScaffold extends StatelessWidget {
  const MScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: TextFormField(
              decoration:InputDecoration(
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                labelText: "Enter your name",
                hintText:"Name",

              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: TextFormField(
                decoration:InputDecoration(
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                  labelText: "Enter your batch",
                  hintText:"Batch",

                )
            ),
          ),
        ],
      ),
    );
  }
}
