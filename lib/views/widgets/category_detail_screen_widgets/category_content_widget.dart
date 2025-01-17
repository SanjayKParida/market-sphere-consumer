import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_sphere/controllers/product/product_controller.dart';
import 'package:market_sphere/controllers/subcategory/subcategory_controller.dart';
import 'package:market_sphere/models/category/category_model.dart';
import 'package:market_sphere/views/widgets/category_detail_screen_widgets/category_banner_widget.dart';
import 'package:market_sphere/views/widgets/category_detail_screen_widgets/subcategory_tile.dart';
import 'package:market_sphere/views/widgets/text_widget.dart';

import '../../../models/product/product_model.dart';
import '../../../models/subcategory/subcategory_model.dart';
import '../custom_app_bar/beautiful_app_bar_widget.dart';
import '../home_screen_widgets/product_item_widget.dart';

class CategoryContentWidget extends StatefulWidget {
  final CategoryModel category;
  const CategoryContentWidget({super.key, required this.category});

  @override
  State<CategoryContentWidget> createState() => _CategoryContentWidgetState();
}

class _CategoryContentWidgetState extends State<CategoryContentWidget> {
  late Future<List<SubcategoryModel>> _subCategories;
  final SubcategoryController _subcategoryController = SubcategoryController();
  late Future<List<ProductModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    _subCategories = _subcategoryController
        .getSubcategoriesByCategoryName(widget.category.name);
    futureProducts =
        ProductController().loadProductByCategory(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.sizeOf(context);
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
            FutureBuilder(
                future: _subCategories,
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshots.hasError) {
                    return Center(
                      child: Text('Error: ${snapshots.error}'),
                    );
                  } else if (!snapshots.hasData || snapshots.data!.isEmpty) {
                    return const Center(
                      child: Text('No Subcategories found'),
                    );
                  } else {
                    final subcategories = snapshots.data!;

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: List.generate(
                            (subcategories.length / 7).ceil(), (setIndex) {
                          //FOR EACH ROW CALCULATE THE STARTING AND ENDING INDICES
                          final start = setIndex * 7;
                          final end = (setIndex + 1) * 7;

                          //CREATE A PADDING WIDGET TO ADD SPACING AROUND THE ROW
                          return Padding(
                            padding: const EdgeInsets.all(9),
                            child: Row(
                              //CREATE A ROW OF THE SUBCATEGORY TILE
                              children: subcategories
                                  .sublist(
                                    start,
                                    end > subcategories.length
                                        ? subcategories.length
                                        : end,
                                  )
                                  .map((subcategory) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SubcategoryTile(
                                          image: subcategory.image,
                                          title: subcategory.subCategoryName,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          );
                        }),
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
