import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:http/http.dart' as http;


class LoginRepo{
  Future<bool> signInWithEmailAndPassword({required String email, required password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Successfully signed in
      print('User ID: ${userCredential.user!.uid}');
      return true;
    } on FirebaseAuthException catch (e) {
      // Handle errors
      print('Error: $e');
      return false;
      // You can show a dialog or display an error message to the user
    }
  }


  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://api.example.com/data'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final data = json.decode(response.body);
      // Do something with the parsed data
      print(data);
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load data');
    }
  }


}