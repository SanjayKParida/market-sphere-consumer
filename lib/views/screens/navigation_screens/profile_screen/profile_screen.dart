import 'package:flutter/material.dart';
import 'package:market_sphere/controllers/authentication/auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController _authController = AuthController();
  bool _isSignOutLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              setState(() {
                _isSignOutLoading = true;
              });
              await _authController.signOutUser(context: context);
              setState(() {
                _isSignOutLoading = false;
              });
            },
            child: _isSignOutLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Sign out',
                    style: TextStyle(color: Colors.white),
                  )),
      ),
    );
  }
}
