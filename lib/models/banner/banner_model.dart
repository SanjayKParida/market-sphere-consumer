import 'dart:convert';

class BannerModel {
  String id;
  String image;

  BannerModel({
    required this.id,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
    };
  }

  factory BannerModel.fromJson(Map<String, dynamic> map) {
    return BannerModel(
      id: map['_id'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => jsonEncode(toMap());
}