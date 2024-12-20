import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:market_sphere/core/constants/constants.dart';
import 'package:market_sphere/models/user/user.dart';
import 'package:http/http.dart' as http;
import 'package:market_sphere/services/api_service.dart';
import 'package:market_sphere/services/snackbar_service.dart';
import 'package:market_sphere/views/screens/authentication_screens/login_screen.dart';
import 'package:market_sphere/views/screens/main_screen/main_screen.dart';

class AuthController {
  Future<void> signUpUsers(
      {required BuildContext context,
      required String email,
      required String fullName,
      required String password}) async {
    try {
      User user = User(
          id: '',
          fullName: fullName,
          email: email,
          state: '',
          city: '',
          locality: '',
          password: password,
          token: '');
      http.Response response = await http.post(Uri.parse("$URI/api/signup"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      //RESPONSE HANDLING
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
            debugPrint("Success");
          });
    } catch (e) {
      debugPrint("ERROR: $e");
      ;
    }
  }

  Future<void> signInUsers(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response response = await http.post(Uri.parse("$URI/api/signin"),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      //RESPONSE HANDLING
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
                (route) => false);
            debugPrint("Logged in");
          });
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }
}
