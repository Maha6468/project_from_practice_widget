import 'package:flutter/material.dart';

class MyCustomContainer extends StatelessWidget {
  final String text;
  final double Height;
  final double Width;
  final Color color;
  final Color borderColor;
  final Color TextCo;

  const MyCustomContainer({super.key,
    required this.text,
    required this.Height,
    required this.Width,
    required this.color,
    required this.borderColor,
    required this.TextCo
  });
  @override
  Widget build(BuildContext context) {
    return  Container(
      height:Height,width:Width,
      child: Text(text,style:TextStyle(color: TextCo),),
      alignment:Alignment.center,
      margin:EdgeInsets.all(20.0),
      padding:EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color:color,
          shape: BoxShape.rectangle,
          border: Border.all(
            color:borderColor,
            width: 5.2,
          )
      ),
      transform: Matrix4.rotationZ(.1),
    );
  }
}