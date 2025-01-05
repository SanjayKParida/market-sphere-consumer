import 'dart:convert';

import 'package:market_sphere/core/constants/constants.dart';
import 'package:market_sphere/models/product/product_model.dart';
import 'package:http/http.dart' as http;

class ProductController {
  //DEFINE A FUNCTION THAT RETURNS A FUTURE CONTAINING LIST OF THE PRODUCT MODEl OBJECTS
  Future<List<ProductModel>> loadPopularProducts() async {
    try {
      http.Response response = await http.get(
          Uri.parse('$URI/api/popular-products'),
          headers: <String, String>{
            "Content-Type": "application/json; charset = UTF-8"
          });
      //CHECKING HTTP RESPONSE
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        //MAP EACH ITEM
        List<ProductModel> popularProducts = data
            .map((product) =>
                ProductModel.fromMap(product as Map<String, dynamic>))
            .toList();
        return popularProducts;
      } else {
        throw Exception("Failed to load popular products");
      }
    } catch (e) {
      throw Exception("ERROR : $e");
    }
  }

  //FUNCTION TO LOAD PRODUCTS BY CATEGORY
  Future<List<ProductModel>> loadProductByCategory(String category) async {
    try {
      http.Response response = await http.get(
          Uri.parse("$URI/api/products-by-category/$category"),
          headers: <String, String>{
            "Content-Type": "application/json; charset = UTF-8"
          });
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        //MAP EACH ITEM
        List<ProductModel> products = data
            .map((product) =>
                ProductModel.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        throw Exception("Failed to load products by category");
      }
    } catch (e) {
      throw Exception("ERROR : $e");
    }
  }
}
