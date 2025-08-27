import 'package:flutter/material.dart';

class CustomFromField extends StatelessWidget {
final String label;
final String hint;
final TextEditingController?controller;
final String? Function(String?)?validator;

  const CustomFromField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 320,
      height: 70,
      child: TextFormField(
        controller: controller,
          validator: validator,
          decoration:InputDecoration(
              border:OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              labelText: label,
              hintText:hint,
              hintStyle: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),


          )
      ),
    );
  }
}
