import 'package:flutter/material.dart';
import 'package:market_sphere/views/widgets/home_screen_widgets/category_item_widget.dart';
import 'package:market_sphere/views/widgets/header_widget.dart';

import '../../../widgets/home_screen_widgets/banner_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(
              hintText: "Search for awesomeness...",
            ),
            BannerWidget(),
            CategoryItemWidget(),
          ],
        ),
      ),
    );
  }
}
