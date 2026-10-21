import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/ProductModel.dart';
import '../dummydata/FarmerMockProduceData.dart';

class FarmerProductListRiverpod extends StateNotifier<List<ProductModel>> {
  FarmerProductListRiverpod() : super(mockFarmerProductList);

  void addProduct(ProductModel product) {
    state = [product, ...state];
  }
}

final FarmerProductListProvider =
StateNotifierProvider<FarmerProductListRiverpod, List<ProductModel>>(
      (ref) => FarmerProductListRiverpod(),
);  