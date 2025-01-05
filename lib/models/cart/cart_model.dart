class CartModel {
  final String productName;
  final int productPrice;
  final String category;
  final List<String> images;
  final String vendorId;
  //QUANTITY AVAILABLE AT THE VENDOR
  final int productQuantity;
  //QUANTITY AN USER WANTS TO BUY
  int quantity;
  final String productId;
  final String description;
  final String fullName;

  CartModel(
      {required this.productName,
      required this.productPrice,
      required this.category,
      required this.images,
      required this.vendorId,
      required this.productQuantity,
      required this.quantity,
      required this.productId,
      required this.description,
      required this.fullName});
}
