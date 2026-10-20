import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/ProductModel.dart';
import '../dummydata/mock_processor_products.dart';

class Processorproductlistriverpod extends StateNotifier<List<ProductModel>> {
  Processorproductlistriverpod() : super(mockProcessorProductList);

  void addProduct(ProductModel product) {
    state = [...state, product];
  }
}

var ProcessorproductlistProvider =
    StateNotifierProvider<Processorproductlistriverpod, List<ProductModel>>(
      (ref) => Processorproductlistriverpod(),
    );
