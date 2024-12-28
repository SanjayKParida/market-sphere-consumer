import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_sphere/models/user/user_model.dart';

class UserProvider extends StateNotifier<UserModel?> {
  UserProvider()
      : super(UserModel(
            id: '',
            fullName: '',
            email: '',
            state: '',
            city: '',
            locality: '',
            password: '',
            token: ''));

  UserModel? get user => state;

  void setUser(String userJson) {
    state = UserModel.fromJson(userJson);
  }
}

final userProvider = StateNotifierProvider<UserProvider, UserModel?>(
  (ref) => UserProvider(),
);
