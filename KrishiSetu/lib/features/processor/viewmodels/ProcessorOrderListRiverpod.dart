import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/OrderModel.dart';
import '../dummydata/mock_processor_orders.dart';

class Processororderlistriverpod extends StateNotifier<List<OrderModel>> {
  Processororderlistriverpod() : super(mockProcessorOrderList);

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

final ProcessororderlistProvider =
StateNotifierProvider<Processororderlistriverpod, List<OrderModel>>(
      (ref) => Processororderlistriverpod(),
);