import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_sphere/models/banner/banner_model.dart';

class BannerProvider extends StateNotifier<List<BannerModel>> {
  BannerProvider() : super([]);

  //SET THE BANNER STATE
  void setBanners(List<BannerModel> banners) {
    state = banners;
  }
}

final bannerProvider = StateNotifierProvider<BannerProvider, List<BannerModel>>(
    (ref) => BannerProvider());
