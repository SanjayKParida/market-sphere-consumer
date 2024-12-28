import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:market_sphere/views/screens/navigation_screens/cart_screen/cart_screen.dart';
import 'package:market_sphere/views/screens/navigation_screens/category_screen/category_screen.dart';
import 'package:market_sphere/views/screens/navigation_screens/home_screen/home_screen.dart';
import 'package:market_sphere/views/screens/navigation_screens/profile_screen/user_screen.dart';
import 'package:market_sphere/views/screens/navigation_screens/stores_screen/stores_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  final List<Widget> pages = const [
    HomeScreen(),
    CategoryScreen(),
    StoresScreen(),
    CartScreen(),
    UserScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex],
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  //BOTTOM NAVIGATION WIDGET
  Widget _bottomNavigation() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: const Color(0xff00059F),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                IconlyLight.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                IconlyLight.category,
              ),
              label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(
                IconlyLight.work,
              ),
              label: 'Stores'),
          BottomNavigationBarItem(
              icon: Icon(
                IconlyLight.buy,
              ),
              label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(
                IconlyLight.user_1,
              ),
              label: 'User')
        ]);
  }
}
