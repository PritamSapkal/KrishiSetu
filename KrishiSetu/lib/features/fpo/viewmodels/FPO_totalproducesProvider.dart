import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dummydata/ProductListingDummyData.dart';

final totalProducesProvider = StateProvider<double>((ref) {

  return mockProductList.fold<double>(
    0.0,
        (previousTotal, product) => previousTotal + (product.quantity ?? 0).toDouble(),
  );
});