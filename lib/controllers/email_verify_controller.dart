import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/app_loading.dart';
import '../common/global_widget.dart';
import '../data/repo/repo.dart';
import 'package:http/http.dart' as http;

class EmailVerifyController extends GetxController {
  TextEditingController emailController = TextEditingController();

  var recaptchaRefresh = false.obs;


  bool validateEmail(String email) {
    // Trim whitespace from email
    email = email.trim();

    // Allow letters, numbers, periods (.), underscores (_), and @
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9._]+\.[a-zA-Z]+$');

    // Check if the email matches the regex
    return emailRegex.hasMatch(email);
  }

  sendVerifyEmail({required String email}) async {
    showLoading();
    try {
      String url = 'https://app.orbaic.com/api/auth/verifyemail?email=$email';
      final response = await http.get(Uri.parse(url));
      print("email verify status code =========> ${response.statusCode}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String result = data['result'];
        successSnack(result);
      } else if (response.statusCode == 400) {
        errorSnack(data["result"]['ErrorMessage']);
      } else {
        errorSnack("Something went wrong, Please contact support");
      }
      hideLoading();
    } catch (e) {
      errorSnack(e.toString());
      print("withdraw setup=========> $e");
      hideLoading();
    }
  }
}