import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/farmer_dummy_data.dart';
import '../../entry/models/farmer_model.dart';

// Base list provider
final farmerListProvider = Provider<List<FarmerModel>>((ref) {
  return farmerslist;
});

class FarmerFilteredListNotifier extends StateNotifier<List<FarmerModel>> {
  final Ref ref;

  FarmerFilteredListNotifier(this.ref) : super(ref.read(farmerListProvider));

  // Search farmers by name or phone
  void filterBySearch(String query) {
    final allFarmers = ref.read(farmerListProvider);
    if (query.trim().isEmpty) {
      state = allFarmers;
    }
    else {
      state = allFarmers.where((farmer) =>
        farmer.fullName.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }


  // Reset to original list
  void resetFilter() {
    state = ref.read(farmerListProvider);
  }
}

// StateNotifierProvider exposing the notifier
final farmerFilteredListProvider = StateNotifierProvider<FarmerFilteredListNotifier, List<FarmerModel>>((ref) {
  return FarmerFilteredListNotifier(ref);
});