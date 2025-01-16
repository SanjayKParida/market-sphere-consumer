import 'package:flutter/material.dart';
import 'package:market_sphere/controllers/authentication/auth_controller.dart';
import 'package:market_sphere/views/screens/order_screen/order_screen.dart';

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
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Container(
                height: size.height * 0.15,
                width: size.width * 0.92,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderScreen(),
                      ),
                    );
                  },
                  child: const Text("My Orders"))
            ],
          ),
        ),
      ),
    )
        // ElevatedButton(
        //     style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        //     onPressed: () async {
        //       setState(() {
        //         _isSignOutLoading = true;
        //       });
        //       await _authController.signOutUser(context: context);
        //       setState(() {
        //         _isSignOutLoading = false;
        //       });
        //     },
        //     child: _isSignOutLoading
        //         ? const Center(
        //             child: CircularProgressIndicator(
        //               color: Colors.white,
        //             ),
        //           )
        //         : const Text(
        //             'Sign out',
        //             style: TextStyle(color: Colors.white),
        //           )),
        );
  }
}
