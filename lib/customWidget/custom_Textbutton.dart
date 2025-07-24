import 'package:flutter/material.dart';

class First_Co_Ro extends StatefulWidget {
  final String text;

  const First_Co_Ro({super.key,
    required this.text,

  });

  @override
  State<First_Co_Ro> createState() => _First_Co_RoState();
}

class _First_Co_RoState extends State<First_Co_Ro> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: (){},
        child: Text(widget.text,style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),),
        style:TextButton.styleFrom(
          side: BorderSide(color: Colors.grey)
        )
      ),
    );
  }
}
