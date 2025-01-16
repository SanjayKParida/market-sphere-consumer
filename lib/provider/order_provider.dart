import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_sphere/models/order/order_model.dart';

class OrderProvider extends StateNotifier<List<OrderModel>> {
  OrderProvider() : super([]);

  //SET THE LIST OF ORDERS
  void setOrders(List<OrderModel> orders) {
    state = orders;
  }
}

final orderProvider =
    StateNotifierProvider<OrderProvider, List<OrderModel>>((ref) {
  return OrderProvider();
});
