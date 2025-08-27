import 'package:flutter/material.dart';
import 'package:project_from_practice_widget/notice/nCustom/cus_AppBar.dart';

class MScaffold extends StatelessWidget {
  const MScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),

    );
  }
}
