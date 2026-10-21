import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dummydata/unified_marketplace_products.dart';

// State Provider for Active Category Filter
final selectedMarketCategoryProvider = StateProvider<String>((ref) => "All");

// State Provider for Search Query
final marketplaceSearchQueryProvider = StateProvider<String>((ref) => "");

// Filtered Marketplace Products Provider
final filteredMarketplaceProvider = Provider<List<MarketplaceItem>>((ref) {
  final selectedCategory = ref.watch(selectedMarketCategoryProvider);
  final searchQuery = ref.watch(marketplaceSearchQueryProvider).trim().toLowerCase();

  return unifiedMarketplaceList.where((item) {
    final matchesCategory = selectedCategory == "All" ||
        (item.product.category ?? '').toLowerCase() == selectedCategory.toLowerCase();

    final matchesSearch = searchQuery.isEmpty ||
        (item.product.name ?? '').toLowerCase().contains(searchQuery) ||
        (item.sellerName).toLowerCase().contains(searchQuery);

    return matchesCategory && matchesSearch;
  }).toList();
});