import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_sphere/views/screens/category_details/category_detail_screen.dart';
import 'package:market_sphere/views/widgets/text_widget.dart';

import '../../../controllers/category/category_controller.dart';
import '../../../models/category/category_model.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  State createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State {
  late Future<List<CategoryModel>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: TextWidget(title: "Categories", subtitle: "View All"),
        ),
        FutureBuilder<List<CategoryModel>>(
          future: futureCategories,
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshots.hasError) {
              return Center(
                child: Text('Error : ${snapshots.error}'),
              );
            } else if (!snapshots.hasData || snapshots.data!.isEmpty) {
              return const Center(
                child: Text("No Categories"),
              );
            } else {
              final categories = snapshots.data;
              return SizedBox(
                height: 100,
                child: GridView.builder(
                  physics:
                      const NeverScrollableScrollPhysics(), // Prevents scrolling if not needed
                  padding: EdgeInsets.zero, // Removes default padding
                  itemCount: categories!.length > 4 ? 4 : categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing:
                        8, // Add controlled spacing between grid items
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryDetailScreen(
                              category: category,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, // Minimize column height
                        children: [
                          Image.network(
                            category.image,
                            height: 40,
                            width: 40,
                          ),
                          const SizedBox(
                              height:
                                  4), // Controlled space between image and text
                          Text(
                            category.name,
                            style: GoogleFonts.quicksand(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
