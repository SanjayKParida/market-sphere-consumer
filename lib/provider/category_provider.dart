import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_sphere/models/category/category_model.dart';

class CategoryProvider extends StateNotifier<List<CategoryModel>> {
  CategoryProvider() : super([]);

  //SET THE LIST OF CATEGORIES
  void setCategories(List<CategoryModel> categories) async {
    state = categories;
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryProvider, List<CategoryModel>>(
        (ref) => CategoryProvider());
