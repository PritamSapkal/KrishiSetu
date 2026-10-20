import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/OrderModel.dart';
import '../dummydata/mock_processor_orders.dart';

class Processororderlistriverpod extends StateNotifier<List<OrderModel>> {
  Processororderlistriverpod() : super(mockProcessorOrderList);
}

var ProcessororderlistProvider =
    StateNotifierProvider<Processororderlistriverpod, List<OrderModel>>(
      (ref) => Processororderlistriverpod(),
    );
