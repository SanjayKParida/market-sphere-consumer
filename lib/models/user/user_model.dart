import 'dart:convert';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
    required this.token,
  });

  //SERIALIZATION: CONVERT USER MODEL TO MAP
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "fullName": fullName,
      "email": email,
      "state": state,
      "city": city,
      "locality": locality,
      "password": password,
      "token": token
    };
  }

  //SERIALIZATION: CONVERT MAP TO JSON STRING
  String toJson() => jsonEncode(toMap());

  //DESERIALIZATION: CONVERT MAP TO USER MODEL
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['_id'] as String? ?? "",
        fullName: map['fullName'] as String? ?? "",
        email: map['email'] as String? ?? "",
        state: map['state'] as String? ?? "",
        city: map['city'] as String? ?? "",
        locality: map['locality'] as String? ?? "",
        password: map['password'] as String? ?? "",
        token: map['token'] as String? ?? "");
  }

  //DESERIALIZATION: CONVERT JSON STRING TO MAP
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
