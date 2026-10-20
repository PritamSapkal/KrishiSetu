import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/OrderModel.dart';
import '../dummydata/Shg_OrderDummyList.dart';

class SHGOrderListRiverpod extends StateNotifier<List<OrderModel>> {
  SHGOrderListRiverpod() : super(mockShgOrderList);

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

final ShgorderlistProvider =
StateNotifierProvider<SHGOrderListRiverpod, List<OrderModel>>(
      (ref) => SHGOrderListRiverpod(),
);