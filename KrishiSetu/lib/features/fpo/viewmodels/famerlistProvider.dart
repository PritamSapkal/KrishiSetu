import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dummydata/farmer_dummy_data.dart';
import '../models/farmer_model.dart';


final farmerListProvider = StateProvider<List<FarmerModel>>((ref) {
  return farmerslist;
});


final farmerSearchQueryProvider = StateProvider<String>((ref) => '');

// 3. Computed / derived filtered list (recomputes automatically on any change)
final farmerFilteredListProvider = Provider<List<FarmerModel>>((ref) {
  final allFarmers = ref.watch(farmerListProvider);
  final query = ref.watch(farmerSearchQueryProvider).trim().toLowerCase();

  if (query.isEmpty) {
    return allFarmers;
  }

  return allFarmers
      .where((farmer) => farmer.fullName.toLowerCase().contains(query))
      .toList();
});