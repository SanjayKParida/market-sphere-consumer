import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_sphere/views/widgets/home_screen_widgets/category_item_widget.dart';
import 'package:market_sphere/views/widgets/custom_app_bar/beautiful_app_bar_widget.dart';
import 'package:market_sphere/views/widgets/home_screen_widgets/popular_widget.dart';
import '../../../widgets/home_screen_widgets/banner_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: const SingleChildScrollView(
        child: Column(
          children: [
            BeautifulAppBar(hintText: "Search for products"),
            BannerWidget(),
            CategoryItemWidget(),
            PopularWidget(),
          ],
        ),
      ),
    );
  }
}
