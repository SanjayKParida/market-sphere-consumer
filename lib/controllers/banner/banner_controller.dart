import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants/constants.dart';
import '../../models/banner/banner_model.dart';

class BannerController {
  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$URI/api/banner'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> bannerData = jsonDecode(response.body);

        List<BannerModel> banners = bannerData
            .map(
              (banner) => BannerModel.fromJson(banner),
            )
            .toList();
        return banners;
      } else {
        throw Exception('Failed to load banners');
      }
    } catch (e) {
      throw Exception('Error : $e');
    }
  }
}
