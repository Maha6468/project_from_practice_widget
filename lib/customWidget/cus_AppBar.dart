

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:Text("WhatsApp",style: TextStyle(
        color: Colors.white,
        fontWeight:FontWeight.w700,
      ),),
      backgroundColor: Colors.black87,
      actions: [
        IconButton(
          onPressed: (){

          },
          icon: Icon(Icons.camera_alt_outlined,color: Colors.white,),),
        IconButton(
          onPressed: (){

          },
          icon: Icon(Icons.search,color: Colors.white,),),
        IconButton(
          onPressed: (){

          },
          icon: Icon(Icons.more_vert,color: Colors.white,),),

      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(.70),
        child: Container(
          color: Colors.grey.withOpacity(0.2),
          height: 1.0,
        ),
      ),
    );
  }


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
