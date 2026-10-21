import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/ProductModel.dart';
import '../models/cart_item_model.dart';

class CartStateNotifier extends StateNotifier<List<CartItemModel>> {
  CartStateNotifier() : super([]);

  // Add product to cart or increment if it already exists
  void addToCart(ProductModel product, String sellerRole) {
    final existingIndex = state.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      final updatedItem = state[existingIndex].copyWith(
        quantity: state[existingIndex].quantity + 1,
      );
      final updatedList = List<CartItemModel>.from(state);
      updatedList[existingIndex] = updatedItem;
      state = updatedList;
    } else {
      state = [
        ...state,
        CartItemModel(product: product, quantity: 1, sellerRole: sellerRole),
      ];
    }
  }

  // Increment item quantity
  void incrementQuantity(String productId) {
    state = [
      for (final item in state)
        if (item.product.id == productId)
          item.copyWith(quantity: item.quantity + 1)
        else
          item,
    ];
  }

  // Decrement item quantity (removes item if quantity reaches 0)
  void decrementQuantity(String productId) {
    final existingItem = state.firstWhere((item) => item.product.id == productId);
    if (existingItem.quantity > 1) {
      state = [
        for (final item in state)
          if (item.product.id == productId)
            item.copyWith(quantity: item.quantity - 1)
          else
            item,
      ];
    } else {
      removeFromCart(productId);
    }
  }

  // Remove a specific item
  void removeFromCart(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  // Clear cart after checkout
  void clearCart() {
    state = [];
  }
}

// 1. Cart List Provider
final cartProvider = StateNotifierProvider<CartStateNotifier, List<CartItemModel>>(
      (ref) => CartStateNotifier(),
);

// 2. Computed Total Items Count (for cart badge counter)
final cartItemsCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold<int>(0, (sum, item) => sum + item.quantity);
});

// 3. Computed Cart Subtotal Price
final cartSubtotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
});