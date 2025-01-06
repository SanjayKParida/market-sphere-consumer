import 'package:market_sphere/models/order/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:market_sphere/services/api_service.dart';
import 'package:market_sphere/services/snackbar_service.dart';

import '../../core/constants/constants.dart';

class OrderController {
  //FUNCTION TO UPLOAD ORDERS
  uploadOrders(
      {required String id,
      required String fullName,
      required String email,
      required String state,
      required String city,
      required String locality,
      required String productName,
      required int productPrice,
      required int quantity,
      required String category,
      required String image,
      required String buyerId,
      required String vendorId,
      required bool processing,
      required bool delivered,
      required context}) async {
    try {
      final order = OrderModel(
          id: id,
          fullName: fullName,
          email: email,
          state: state,
          city: city,
          locality: locality,
          productName: productName,
          productPrice: productPrice,
          quantity: quantity,
          category: category,
          image: image,
          buyerId: buyerId,
          vendorId: vendorId,
          processing: processing,
          delivered: delivered);
      http.Response response = await http.post(Uri.parse('$URI/api/orders'),
          body: order.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackbar(context, "Order placed successfully!");
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
