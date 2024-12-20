import 'package:flutter/material.dart';
import 'package:market_sphere/views/screens/authentication_screens/login_screen.dart';
import 'package:market_sphere/views/screens/authentication_screens/register_screen.dart';
import 'package:market_sphere/views/screens/main_screen/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}
