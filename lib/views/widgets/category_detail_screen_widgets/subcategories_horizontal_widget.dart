import 'package:flutter/material.dart';

import '../../../controllers/subcategory/subcategory_controller.dart';
import '../../../models/category/category_model.dart';
import '../../../models/subcategory/subcategory_model.dart';
import 'subcategory_tile.dart';

class SubcategoriesHorizontalWidget extends StatefulWidget {
  final CategoryModel category;

  const SubcategoriesHorizontalWidget({super.key, required this.category});

  @override
  State<SubcategoriesHorizontalWidget> createState() =>
      _SubcategoriesHorizontalWidgetState();
}

class _SubcategoriesHorizontalWidgetState
    extends State<SubcategoriesHorizontalWidget> {
  late Future<List<SubcategoryModel>> _subCategories;
  final SubcategoryController _subcategoryController = SubcategoryController();

  @override
  void initState() {
    super.initState();
    _subCategories = _subcategoryController
        .getSubcategoriesByCategoryName(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                children: List.generate((subcategories.length / 7).ceil(),
                    (setIndex) {
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
        });
  }
}
