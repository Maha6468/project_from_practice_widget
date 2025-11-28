import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../common/app_loading.dart';
import '../common/global_widget.dart';
import '../common/perfrance.dart';
import '../common/string.dart';
import '../data/network/dio_client.dart';
import '../data/repo/repo.dart';
import '../repository/auth/register_repo.dart';
import '../routes/app_pages.dart';
import '../views/widgets/dialogs.dart';

class AuthController extends GetxController {
  var isPasswordVisibleLogin = true.obs;
  var isPasswordVisibleRegPass = true.obs;
  var isPasswordVisibleRegConfirmPass = true.obs;
  var passwordSave = false.obs;
  var isTermsAndPolicyAccepted = false.obs;
  var selectedCountryCode = "".obs;
  final RxBool isValidPassword = true.obs;
  var isRegisterPasswordsMatched = false.obs;
  var country = "".obs;
  var confirmPassString = "".obs;
  var registerPasswordString = "".obs;
  var phoneNumberString = "".obs;
  final formKeyPass = GlobalKey<FormState>();
  final formKeyConfirmPass = GlobalKey<FormState>();

  // regular expression to check if string
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  var password_strength = 0.0.obs;
  var isAllDataFilled = false.obs;
  var countryCode = "US".obs;
  final _cache = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: "806056413861-c02ligebfkg0ffvf5d8k9a9rpj05ef9s.apps.googleusercontent.com", scopes: [
    'email',],);
  RegExp emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerFullNameController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerConfirmPasswordController = TextEditingController();

  var isPasswordValid = false.obs;

  var recaptchaRefresh = false.obs;

  var arguments = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((v) {
      Future.delayed(const Duration(microseconds: 100)).then((_) {
        if (arguments != null && arguments is Map) {
          loginEmailController.text = arguments['email'];
          loginPasswordController.text = arguments['password'];
        } else {
          if(_cache.hasData("email")) {
            loginEmailController.text = _cache.read("email");
            loginPasswordController.text = _cache.read("password");
          } else{
            loginEmailController.text = "";
            loginPasswordController.text = "";
            passwordSave.value = false;
          }

          if(_cache.hasData("save")){
            passwordSave.value = _cache.read("save");
          }
        }
      });
    });
  }

  //***************************** Log in Api ************************************/
  void login({
    required String email,
    required String password,
  }) async {
    print("Sakib Checking email: $email\nSakib Checking password: $password");
    try {
      showLoading();
      final response = await UserRepo.getInstance().userLogin(
        data: {
          "email": email.trim(),
          "password": password,
        },
      );

      response.fold(
            (error) {
          print("Sakib Checking Login Error: ${error.toString()}");
          try {
            // Remove leading and trailing whitespace and curly braces
            error = error.trim().substring(1, error.length - 1);

            // Split the string into key-value pairs
            List<String> keyValuePairs = error.split(',');

            // Create a Map to hold key-value pairs
            Map<String, String> errorMap = {};
            for (String pair in keyValuePairs) {
              List<String> parts = pair.split(':');
              if (parts.length == 2) {
                // Remove leading and trailing whitespace and quotes
                String key = parts[0].trim().replaceAll("'", "");
                String value = parts[1].trim().replaceAll("'", "");
                errorMap[key] = value;
              }
            }

            // Extract the error message
            String errorMessage = errorMap["ErrorMessage"] ?? "Unknown error";
            print("error_msg===============>$errorMessage");

            // Show the error message
            errorSnack(errorMessage);

          } catch (e) {
            // If extraction fails, show the original error string
            errorSnack(error.toString());
          }
          hideLoading();
        },
            (r) async {
          // isNavigated = false;
          print(r);
          if (r.result != null) {
            print('AccessToken: ${r.result!.accessToken}');
            await PreferenceHelper.instance
                .setData(Pref.emailId, loginEmailController.text);
            await PreferenceHelper.instance
                .setData(Pref.token, r.result!.accessToken);
            var token = await PreferenceHelper.instance.getData(Pref.token) ?? "";
            print(token);
            isNavigated = false;
            if(passwordSave.value){
              await _cache.write("email", email);
              await _cache.write("password", password);
            } else{
              await _cache.remove("email");
            }
            await _cache.write("save", passwordSave.value);
            successSnack(AppString.LoginSuceeesful);
            Get.offAllNamed(Routes.MAIN);
            final action = await Dialogs.orbaicMiningPortalDialog(Get.context!, "You have successfully accessed the Orbaic Mining portal.");
          }
          loginEmailController.clear();
          loginPasswordController.clear();
          hideLoading();
        },
      );
    } catch (e) {
      print('Login Exception: $e');
      errorSnack("$e");
      hideLoading();
    }
  }

  Future<bool> registerWithEmailAndPassword(BuildContext context) async {
    RegisterRepo repo = RegisterRepo();
    bool b = await repo.registerWithEmailAndPassword(
        context: context,
        fullname: registerFullNameController.text,
        phone: phoneNumberString.value.trim(),
        email: registerEmailController.text.trim().toLowerCase(),
        password: registerPasswordString.value);
    return b;
  }


  bool validateEmail(String email) {
    // Trim whitespace from email
    email = email.trim();

    // Allow letters, numbers, periods (.), underscores (_), and @
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9._]+\.[a-zA-Z]+$');

    // Check if the email matches the regex
    return emailRegex.hasMatch(email);
  }

  // bool validateEmail(String email){
  //   email = email.trim();
  //   if(emailValid.hasMatch(email)){
  //     return true;
  //   }
  //   return false;
  // }

  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (_password.isEmpty) {
      password_strength.value = 0;
    } else if (_password.length < 6) {
      password_strength.value = 1 / 4;
    } else if (_password.length < 8) {
      password_strength.value = 2 / 4;
    } else {
      if (pass_valid.hasMatch(_password)) {
        password_strength.value = 4 / 4;
        return true;
      } else {
        password_strength.value = 3 / 4;
        return false;
      }
    }
    return false;
  }

  void setAllDataValidated() {
    print("Check registerFullName: "
        '${registerFullNameController.text.isNotEmpty}');
    print("Check phoneNumberString: " '${phoneNumberString.isNotEmpty}');
    print(
        "Check isTermsAndPolicyAccepted: " '${isTermsAndPolicyAccepted.value}');
    print("Check registerEmailController: "
        '${registerEmailController.text.isNotEmpty}');
    print("Check registerPasswordString: "
        '${validatePassword(registerPasswordString.value)}');
    if (registerFullNameController.text.isNotEmpty &&
        phoneNumberString.isNotEmpty &&
        isRegisterPasswordsMatched.value &&
        isTermsAndPolicyAccepted.value &&
        registerEmailController.text.trim().isNotEmpty &&
        validatePassword(registerPasswordString.value)) {
      isAllDataFilled.value = true;
    } else {
      isAllDataFilled.value = false;
    }
  }


  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      countryCode.value = "US";
      // Handle the case where the user denies permission
    } else if (permission == LocationPermission.deniedForever) {
      countryCode.value = "US";
      // Handle the case where the user permanently denies permission
    } else {
      // Permission granted, proceed to get the location
      Position position = await Geolocator.getCurrentPosition();
      countryCode.value = (await getCountryFromLocation(position))!;
      //  countryCode.value = "3166-2";
      // Now, you can use the position to get the country
    }
  }

  Future<String?> getCountryFromLocation(Position position) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        country.value = placemarks[0].country!;
        return placemarks[0].isoCountryCode;
      } else {
        return "Unknown";
      }
    } catch (e) {
      print("Error getting country: $e");
      return "Unknown";
    }
  }

  void googleLogin(){
    generalErrorSnack("Google login not available", "This feature is coming soon.");
    //errorSnack("This service is not available at this moment");
  }
  void appleLogin(){
    generalErrorSnack("Apple login not available", "This feature is coming soon.");
  }

  Future<void> signInWithGoogle() async {
    showLoading();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? authentication = await googleUser?.authentication;
      if (googleUser == null || authentication == null) {
        hideLoading();
        return;
      } else{
        hideLoading();
        print("IdToken: ${authentication.idToken}");
        String? accessToken = authentication.idToken;
        String? email = googleUser.email;
        String? displayName = googleUser.displayName;
        String? id = googleUser.id;
        await _googleSignIn.signOut();
        googleFinalLogin(accessToken: accessToken!, email: email, displayName: displayName!, id: id);
      }

    } catch (e) {
      print(e);
      hideLoading();
      return;
    }
  }


  //***************************** Google Final Log in Api ************************************/
  void googleFinalLogin({
    required String accessToken,
    required String email,
    required String displayName,
    required String id,
  }) async {
    print("Sakib Checking email: $email");
    print("Sakib Checking accessToken: $accessToken");
    print("Sakib Checking displayName: $displayName");
    print("Sakib Checking id: $id");
    try {
      showLoading();
      final response = await UserRepo.getInstance().googleSignIn(
        data: {
          "accessToken": accessToken,
          "email": email,
          "displayName": displayName,
          "id": id
        },
      );

      response.fold(
            (error) {
          print("Sakib Checking Login Error: ${error.toString()}");
          try {
            // Remove leading and trailing whitespace and curly braces
            error = error.trim().substring(1, error.length - 1);

            // Split the string into key-value pairs
            List<String> keyValuePairs = error.split(',');

            // Create a Map to hold key-value pairs
            Map<String, String> errorMap = {};
            for (String pair in keyValuePairs) {
              List<String> parts = pair.split(':');
              if (parts.length == 2) {
                // Remove leading and trailing whitespace and quotes
                String key = parts[0].trim().replaceAll("'", "");
                String value = parts[1].trim().replaceAll("'", "");
                errorMap[key] = value;
              }
            }

            // Extract the error message
            String errorMessage = errorMap["ErrorMessage"] ?? "Unknown error";

            // Show the error message
            errorSnack(errorMessage);
          } catch (e) {
            // If extraction fails, show the original error string
            errorSnack(error.toString());
          }
          hideLoading();
        },
            (r) async {
          // isNavigated = false;
          print(r);
          if (r.result != null) {
            print('AccessToken: ${r.result!.accessToken}');
            await PreferenceHelper.instance
                .setData(Pref.token, r.result!.accessToken);
            var token = await PreferenceHelper.instance.getData(Pref.token) ?? "";
            print(token);
            isNavigated = false;
            successSnack(AppString.LoginSuceeesful);
            Get.offAllNamed(Routes.MAIN);
            final action = await Dialogs.orbaicMiningPortalDialog(Get.context!, "You have successfully accessed the Orbaic Mining portal.");
          }
          loginEmailController.clear();
          loginPasswordController.clear();
          hideLoading();
        },
      );
    } catch (e) {
      print('Login Exception: $e');
      errorSnack("$e");
      hideLoading();
    }
  }

}


//maha
extension on Function() {
  Future getData(String token) async {}

  Future<void> setData(String token, String? accessToken) async {}
}



