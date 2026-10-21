import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/OrderModel.dart';
import '../dummydata/farmerOrderDummydata.dart';

class FarmerOrderListRiverpod extends StateNotifier<List<OrderModel>> {
  FarmerOrderListRiverpod() : super(mockFarmerOrderList);

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

final FarmerOrderListProvider =
StateNotifierProvider<FarmerOrderListRiverpod, List<OrderModel>>(
      (ref) => FarmerOrderListRiverpod(),
);