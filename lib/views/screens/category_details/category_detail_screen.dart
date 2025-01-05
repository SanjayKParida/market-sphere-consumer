import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_sphere/controllers/product/product_controller.dart';
import 'package:market_sphere/models/category/category_model.dart';
import 'package:market_sphere/views/widgets/category_detail_screen_widgets/category_banner_widget.dart';
import 'package:market_sphere/views/widgets/custom_app_bar/beautiful_app_bar_widget.dart';
import 'package:market_sphere/views/widgets/home_screen_widgets/product_item_widget.dart';
import 'package:market_sphere/views/widgets/text_widget.dart';

import '../../../models/product/product_model.dart';
import '../../widgets/category_detail_screen_widgets/subcategories_horizontal_widget.dart';

class CategoryDetailScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryDetailScreen({super.key, required this.category});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  late Future<List<ProductModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts =
        ProductController().loadProductByCategory(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BeautifulAppBar(hintText: "Search"),
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
            SubcategoriesHorizontalWidget(category: widget.category),
            const TextWidget(title: "Popular Products", subtitle: ""),
            FutureBuilder(
                future: futureProducts,
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshots.hasError) {
                    return Center(
                      child: Text("Error : ${snapshots.error}"),
                    );
                  } else if (!snapshots.hasData || snapshots.data!.isEmpty) {
                    return const Center(
                      child: Text("No Popular Products"),
                    );
                  } else {
                    final popularProducts = snapshots.data;
                    return SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: popularProducts!.length,
                        itemBuilder: (context, index) {
                          final product = popularProducts[index];
                          return ProductItemWidget(
                            product: product,
                          );
                        },
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
