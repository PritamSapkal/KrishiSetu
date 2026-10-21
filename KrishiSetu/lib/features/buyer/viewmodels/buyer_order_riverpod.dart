import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/OrderModel.dart';

// Initial demo orders placed by the Buyer
final List<OrderModel> initialBuyerOrders = [
  OrderModel(
    id: "BYR_ORD_7001",
    buyerId: "6abe08d8b9e86f93f1989df0",
    productId: "FAR_PRD_001",
    name: "Raw Maldandi Jowar (Sorghum)",
    imageUrl: "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?auto=format&fit=crop&w=500&q=80",
    quantity: 2.0,
    unit: "QUINTAL",
    pricePerUnit: 3400.0,
    totalPrice: 6800.0,
    status: OrderStatus.CONFIRMED,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 4)),
  ),
  OrderModel(
    id: "BYR_ORD_7002",
    buyerId: "6abe08d8b9e86f93f1989df0",
    productId: "6708db421a9c8f2b34a10004",
    name: "Roasted Multi-Millet Flour",
    imageUrl: "https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=500&q=80",
    quantity: 5.0,
    unit: "PACKS",
    pricePerUnit: 80.0,
    totalPrice: 400.0,
    status: OrderStatus.SHIPPED,
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
];

class BuyerOrderNotifier extends StateNotifier<List<OrderModel>> {
  BuyerOrderNotifier() : super(initialBuyerOrders);

  // Add newly created orders from Checkout
  void addOrders(List<OrderModel> newOrders) {
    state = [...newOrders, ...state];
  }

  // Cancel order (DeleteOrder operation)
  void cancelOrder(String orderId) {
    state = [
      for (final order in state)
        if (order.id == orderId)
          order.copyWith(status: OrderStatus.CANCELLED, updatedAt: DateTime.now())
        else
          order,
    ];
  }
}

final buyerOrderListProvider =
StateNotifierProvider<BuyerOrderNotifier, List<OrderModel>>(
      (ref) => BuyerOrderNotifier(),
);