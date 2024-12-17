import 'package:flutter/material.dart';
import 'package:market_sphere/core/constants/constants.dart';
import 'package:market_sphere/models/user/user.dart';
import 'package:http/http.dart' as http;
import 'package:market_sphere/services/api_service.dart';
import 'package:market_sphere/services/snackbar_service.dart';

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
          password: password);
      http.Response response = await http.post(Uri.parse("$URI/api/signup"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            debugPrint("Success");
          });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
