import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_sphere/controllers/subcategory/subcategory_controller.dart';
import 'package:market_sphere/models/subcategory/subcategory_model.dart';
import 'package:market_sphere/views/widgets/header_widget.dart';

import '../../../../controllers/category/category_controller.dart';
import '../../../../models/category/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<CategoryModel>> futureCategories;
  CategoryModel? _selectedCategory;
  List<SubcategoryModel> _subcategories = [];
  final SubcategoryController _subcategoryController = SubcategoryController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
    futureCategories.then((categories) {
      for (var category in categories) {
        if (category.name == "Fashion") {
          //DEFAULTING FASHION CATEGORY
          setState(() {
            _selectedCategory = category;
          });
          _loadSubcategories(category.name);
        }
      }
    });
  }

  //FETCH SUBCATEGORIES BASED ON SELECTED CATEGORY
  Future<void> _loadSubcategories(String categoryName) async {
    final subcategories = await _subcategoryController
        .getSubcategoriesByCategoryName(categoryName);
    setState(() {
      _subcategories = subcategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 20),
          child: const HeaderWidget(hintText: "Search")),
      body: Row(
        children: [
          //LEFT SiDE DISPLAY CATEGORIES
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade200,
              child: FutureBuilder(
                  future: futureCategories,
                  builder: (context, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshots.hasError) {
                      return Center(
                        child: Text("${snapshots.error}"),
                      );
                    } else {
                      final categories = snapshots.data!;
                      return ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return ListTile(
                            onTap: () {
                              setState(() {
                                _selectedCategory = category;
                              });
                              _loadSubcategories(category.name);
                            },
                            title: Text(
                              category.name,
                              style: GoogleFonts.quicksand(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedCategory == category
                                      ? Colors.blue
                                      : Colors.grey),
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),
          ),
          //RIGHT SIDE - DISPLAY SELECTED CATEGORY DETAILS
          Expanded(
            flex: 5,
            child: _selectedCategory != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _selectedCategory!.name,
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: _isLoading
                            ? Container(
                                height: 150,
                                color: Colors.grey,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : ClipRRect(
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          _selectedCategory!.banner,
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                      ),
                      _subcategories.isNotEmpty
                          ? GridView.builder(
                              shrinkWrap: true,
                              itemCount: _subcategories.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 4,
                              ),
                              itemBuilder: (context, index) {
                                final subcategory = _subcategories[index];
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    subcategory.image),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.shade200),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Center(
                                        child:
                                            Text(subcategory.subCategoryName),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Text(
                                "No Subcategories",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                    ],
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
