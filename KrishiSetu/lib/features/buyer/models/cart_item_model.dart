import '../../../core/models/ProductModel.dart';

class CartItemModel {
  final ProductModel product;
  final int quantity; // Selected cart units
  final String sellerRole; // "Farmer", "FPO", "SHG", "Processor"

  const CartItemModel({
    required this.product,
    this.quantity = 1,
    required this.sellerRole,
  });

  double get totalPrice => (product.price?.toDouble() ?? 0.0) * quantity;

  CartItemModel copyWith({
    ProductModel? product,
    int? quantity,
    String? sellerRole,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      sellerRole: sellerRole ?? this.sellerRole,
    );
  }
}