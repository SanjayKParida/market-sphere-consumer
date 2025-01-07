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
      required WidgetRef ref,
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
          onSuccess: () async {
            //GET SHARED PREFERENCES INSTANCE
            SharedPreferences prefs = await SharedPreferences.getInstance();

            //EXTRACT TOKEN FROM THE RESPONSE
            String token = json.decode(response.body)['token'];
            await prefs.setString('auth_token', token);

            //EXTRACT USER DATA FROM RESPONSE AND SAVE IT
            final userJson = jsonEncode(json.decode(response.body)['user']);
            ref.read(userProvider.notifier).setUser(userJson);

            //PRINT THE UPDATED USER DATA
            final updatedUser =
                ref.read(userProvider); // Read updated user state
            print('User state after sign-in: $updatedUser');

            //SAVE THE USER DATA IN SHARED PREFERENCES
            await prefs.setString('user', userJson);

            //NAVIGATE TO MAIN SCREEN
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

  //UPDATE USER'S ADDRESS
  Future<void> updateUserAddress({
    required context,
    required String id,
    required String state,
    required String city,
    required String locality,
  }) async {
    try {
      //MAKE AN HTTP PUT REQUEST TO UPDATE USER'S ADDRESS
      http.Response response = await http.put(Uri.parse('$URI/api/users/$id'),
          //ENCODE THE UPDATED DATA AS JSON OBJECT
          body: jsonEncode({
            "state": state,
            "city": city,
            "locality": locality,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () async {
            //DECODE THE UPDATED USER DATA FROM THE RESPONSE BODY
            //CONVERSION OF JSON STRING RESPONSE INTO DART MAP
            final updatedUser = jsonDecode(response.body);
            //ACCESS THE SHARED PREFERENCES FOR LOCAL DATA STORAGE
            SharedPreferences prefs = await SharedPreferences.getInstance();
            //ENCODE THE UPDATED USER DATA AS JSON STRING
            final userJson = jsonEncode(updatedUser);

            //UPDATE THE APPLICATION STATE USING RIVERPOD
            providerContainer.read(userProvider.notifier).setUser(userJson);

            //STORE THE UDPATED USER IN THE SHARED PREFERENCES FOR FUTURE USE
            await prefs.setString('user', userJson);
          });
    } catch (e) {
      showSnackbar(context, "$e");
    }
  }
}
