import 'package:flutter/material.dart';

 class CustomAppBar extends StatelessWidget implements PreferredSizeWidget  {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Notice"),
      backgroundColor: Colors.cyanAccent,
      centerTitle:true,
    );
  }
  @override Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);




}
