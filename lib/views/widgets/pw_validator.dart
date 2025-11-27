import 'package:flutter/material.dart';

class PwValidator extends StatefulWidget {
  PwValidator({super.key, required this.controller, required this.onValidate});

  final TextEditingController controller;
  final Function(bool) onValidate;

  @override
  State<PwValidator> createState() => _PwValidatorState();
}

class _PwValidatorState extends State<PwValidator> {
  String password = "";
  bool isPasswordValid = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.addListener(() {
        if (mounted) {
          setState(() {
            password = widget.controller.text;
            print("pw_validator=====> ${password}");

            // Validation logic
            bool hasWord = RegExp(r'[a-zA-Z]').hasMatch(password);
            bool hasNumber = RegExp(r'[0-9]').hasMatch(password);
            bool hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

            isPasswordValid = hasWord && hasNumber && hasSpecialChar;

            widget.onValidate(isPasswordValid);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password must contain:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        _buildValidationText("At least a word", RegExp(r'[a-zA-Z]').hasMatch(password)),
        _buildValidationText("At least a number", RegExp(r'[0-9]').hasMatch(password)),
        _buildValidationText("At least a special character", RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)),
      ],
    );
  }


  Widget _buildValidationText(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? const Color(0xFF64D2FF) : Colors.blueGrey,
          size: 20,
        ),
        SizedBox(width: 8),
        Text(text, style: TextStyle(color: isValid ? const Color(0xFF64D2FF) : Colors.blueGrey),),
      ],
    );
  }
}

