import 'package:flutter/material.dart';

import '../../../controllers/banner/banner_controller.dart';
import '../../../models/banner/banner_model.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> banners;

  @override
  void initState() {
    super.initState();
    banners = BannerController().loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: size.width,
          height: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFFF7F7F7),
          ),
          child: FutureBuilder(
            future: banners,
            builder: (context, snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshots.hasError) {
                return Center(
                  child: Text("Error: ${snapshots.error}"),
                );
              } else if (!snapshots.hasData || snapshots.data!.isEmpty) {
                return const Center(
                  child: Text("No Banners"),
                );
              } else {
                final data = snapshots.data!;

                return PageView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final banner = data[index];
                    return Image.network(
                      banner.image,
                      fit: BoxFit.cover,
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
