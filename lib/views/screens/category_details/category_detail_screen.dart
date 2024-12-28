import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_sphere/models/category/category_model.dart';
import 'package:market_sphere/views/widgets/category_detail_screen_widgets/category_banner_widget.dart';

import '../../widgets/category_detail_screen_widgets/category_header_widget.dart';
import '../../widgets/category_detail_screen_widgets/subcategories_horizontal_widget.dart';

class CategoryDetailScreen extends StatefulWidget {
  final CategoryModel category;
  const CategoryDetailScreen({super.key, required this.category});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 20),
        child: const CategoryHeaderWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoryBannerWidget(image: widget.category.banner),
            Center(
              child: Text(
                'Shop by Subcategories',
                style: GoogleFonts.quicksand(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            SubcategoriesHorizontalWidget(category: widget.category)
          ],
        ),
      ),
    );
  }
}
