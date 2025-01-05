import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_sphere/models/cart/cart_model.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<String, CartModel>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<Map<String, CartModel>> {
  CartNotifier() : super({});

  void addProductToCart({
    required String productName,
    required int productPrice,
    required String category,
    required List<String> images,
    required String vendorId,
    required int productQuantity,
    required int quantity,
    required String productId,
    required String description,
    required String fullName,
  }) {
    // Check if product is already in the cart
    if (state.containsKey(productId)) {
      // If product exists, increment its quantity
      final updatedState = Map<String, CartModel>.from(state);
      final existingItem = updatedState[productId]!;

      // Check if incrementing would exceed available quantity
      if (existingItem.quantity < existingItem.productQuantity) {
        updatedState[productId] = CartModel(
          productName: existingItem.productName,
          productPrice: existingItem.productPrice,
          category: existingItem.category,
          images: existingItem.images,
          vendorId: existingItem.vendorId,
          productQuantity: existingItem.productQuantity,
          quantity: existingItem.quantity + 1,
          productId: existingItem.productId,
          description: existingItem.description,
          fullName: existingItem.fullName,
        );
        state = updatedState;
      }
    } else {
      // If product is not in cart, add it with quantity 1
      final updatedState = Map<String, CartModel>.from(state);
      updatedState[productId] = CartModel(
        productName: productName,
        productPrice: productPrice,
        category: category,
        images: images,
        vendorId: vendorId,
        productQuantity: productQuantity,
        quantity: 1, // Start with quantity 1, not the vendor's quantity
        productId: productId,
        description: description,
        fullName: fullName,
      );
      state = updatedState;
    }
  }

  void incrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      final updatedState = Map<String, CartModel>.from(state);
      final item = updatedState[productId]!;

      // Check if incrementing would exceed available quantity
      if (item.quantity < item.productQuantity) {
        item.quantity++;
        state = updatedState;
      }
    }
  }

  void decrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      final updatedState = Map<String, CartModel>.from(state);
      final item = updatedState[productId]!;

      // Only decrement if quantity is greater than 1
      if (item.quantity > 1) {
        item.quantity--;
        state = updatedState;
      }
    }
  }

  void removeCartItem(String productId) {
    final updatedState = Map<String, CartModel>.from(state);
    updatedState.remove(productId);
    state = updatedState;
  }

  double totalCartAmount() {
    double totalAmount = 0.0;
    state.forEach((productId, cartItem) {
      totalAmount += cartItem.quantity * cartItem.productPrice;
    });
    return totalAmount;
  }
}
