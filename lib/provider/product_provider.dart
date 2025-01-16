import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_sphere/models/product/product_model.dart';

class ProductProvider extends StateNotifier<List<ProductModel>> {
  ProductProvider() : super([]);
  //SET THE LIST OF PRODUCTS

  void setProducts(List<ProductModel> products) {
    state = products;
  }
}

final productProvider =
    StateNotifierProvider<ProductProvider, List<ProductModel>>(
        (ref) => ProductProvider());
