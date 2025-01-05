import 'package:flutter/material.dart';
import 'package:market_sphere/controllers/product/product_controller.dart';
import 'package:market_sphere/views/widgets/home_screen_widgets/product_item_widget.dart';

import '../../../models/product/product_model.dart';
import '../text_widget.dart';

class PopularWidget extends StatefulWidget {
  const PopularWidget({super.key});

  @override
  State<PopularWidget> createState() => _PopularWidgetState();
}

class _PopularWidgetState extends State<PopularWidget> {
  //FUTURE THAT WILL HOLD THE POPULAR PRODUCT LIST
  late Future<List<ProductModel>> futurePopularProdcuts;

  @override
  void initState() {
    super.initState();
    futurePopularProdcuts = ProductController().loadPopularProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextWidget(title: "Popular Products", subtitle: "View All"),
        FutureBuilder(
            future: futurePopularProdcuts,
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
    );
  }
}
