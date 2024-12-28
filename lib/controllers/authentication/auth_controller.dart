import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_sphere/core/constants/constants.dart';
import 'package:market_sphere/models/user/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:market_sphere/provider/user_provider.dart';
import 'package:market_sphere/services/api_service.dart';
import 'package:market_sphere/services/snackbar_service.dart';
import 'package:market_sphere/views/screens/authentication_screens/login_screen.dart';
import 'package:market_sphere/views/screens/main_screen/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

class AuthController {
  //SINGUP USERS
  Future<void> signUpUsers(
      {required BuildContext context,
      required String email,
      required String fullName,
      required String password}) async {
    try {
      UserModel user = UserModel(
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
          onSuccess: () async {
            //ACCESS SHARED PREFERENCES FOR TOKEN AND USER DATA STORAGE
            SharedPreferences prefs = await SharedPreferences.getInstance();

            //EXTRACTS THE AUTHENTICATION TOKEN FROM THE BODY
            String token = json.decode(response.body)['token'];

            //STORE THE AUTHENTICATION TOKEN SECURELY IN SHARED PREFERENCES
            await prefs.setString('auth_token', token);

            //ENCODE THE USER DATA RECEIVED FROM THE BACKEND AS JSON
            final userJson = jsonEncode(jsonDecode(response.body)['user']);

            //UPDATE THE APPLICATION STATE WITH THE USER DATA USING RIVERPOD
            providerContainer.read(userProvider.notifier).setUser(userJson);

            //STORE THE DATA IN SHARED PREFERENCES FOR FUTURE USE
            await prefs.setString('user', userJson);

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
            debugPrint("Success");
          });
    } catch (e) {
      debugPrint("ERROR: $e");
      ;
    }
  }

  //SIGNIN USERS
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

  //SIGNOUT USERS
  Future<void> signOutUser({required context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //CLEAR THE TOKEN FROM THE SHARED PREFERENCES
      prefs.remove('auth_token');
      //CLEAR THE USER FROM THE SHARED PREFERENCES
      prefs.remove('user');

      //CLEAR THE USER STATE
      providerContainer.read(userProvider.notifier).signOut();

      //NAVIGATE BACK TO THE LOGIN SCREEN
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);

      showSnackbar(context, "Signed Out!");
    } catch (e) {
      showSnackbar(context, "Error Signing Out: $e");
    }
  }
}
