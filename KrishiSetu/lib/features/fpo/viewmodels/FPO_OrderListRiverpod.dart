import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/OrderModel.dart';
import '../dummydata/OrderDummyList.dart';

class FPOororderlistriverpod extends StateNotifier<List<OrderModel>> {
  FPOororderlistriverpod() : super(mockOrderList);

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    state = [
      for (final order in state)
        if (order.id == orderId)
          order.copyWith(
            status: newStatus,
            updatedAt: DateTime.now(),
          )
        else
          order,
    ];
  }
}

final FPOorderlistProvider =
StateNotifierProvider<FPOororderlistriverpod, List<OrderModel>>(
      (ref) => FPOororderlistriverpod(),
);