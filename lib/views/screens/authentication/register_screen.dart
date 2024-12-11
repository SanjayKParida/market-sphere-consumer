import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Register an account",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    letterSpacing: 0.2),
              ),
              Text(
                "To Explore the World Exclusives",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 0.2),
              ),
              const SizedBox(
                height: 30,
              ),
              SvgPicture.asset('assets/images/signup_illustration.svg',
                  width: size.width * 0.18, height: size.height * 0.18),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your password';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Enter Full Name",
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                          fillColor: Colors.grey[200],
                          prefixIcon: const Icon(IconlyBold.work),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your Email';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Email",
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                          fillColor: Colors.grey[200],
                          prefixIcon: const Icon(IconlyBold.work),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your Password';
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                          fillColor: Colors.grey[200],
                          labelText: "Password",
                          suffixIcon: Icon(IconlyLight.show),
                          prefixIcon: const Icon(IconlyBold.password),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          print('correct');
                        } else {
                          print('failed');
                        }
                      },
                      child: Container(
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(colors: [
                              Color(0xFF63A0FF),
                              Color(0xFF102DE1)
                            ])),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? ',
                            style: GoogleFonts.roboto(fontSize: 14)),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: const Color(0xFF63A0FF)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
