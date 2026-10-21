import '../../../core/models/ProductModel.dart';
import '../../farmer/dummydata/FarmerMockProduceData.dart';
import '../../fpo/dummydata/ProductListingDummyData.dart';
import '../../processor/dummydata/mock_processor_products.dart';
import '../../shg/dummydata/Shg_ProduceDummyList.dart'; // Adjust path if named differently

class MarketplaceItem {
  final ProductModel product;
  final String sellerRole; // "Farmer", "FPO", "SHG", "Processor"
  final String sellerName;

  const MarketplaceItem({
    required this.product,
    required this.sellerRole,
    required this.sellerName,
  });
}

final List<MarketplaceItem> unifiedMarketplaceList = [
  // --- 1. Products from Farmers ---
  ...mockFarmerProductList
      .where((p) => p.active == true)
      .map((p) => MarketplaceItem(
    product: p,
    sellerRole: "Farmer",
    sellerName: "Pritam Sapkal (Farmer)",
  )),

  // --- 2. Products from FPO ---
  ...mockProductList
      .where((p) => p.active == true)
      .map((p) => MarketplaceItem(
    product: p,
    sellerRole: "FPO",
    sellerName: "Sahyadri Agro FPO",
  )),

  // --- 3. Products from SHG (Mahila Bachat Gat) ---
  ...shgProductList
      .where((p) => p.active == true)
      .map((p) => MarketplaceItem(
    product: p,
    sellerRole: "SHG",
    sellerName: "Mahila Samruddhi Bachat Gat",
  )),

  // --- 4. Products from Commercial Processor ---
  ...mockProcessorProductList
      .where((p) => p.active == true)
      .map((p) => MarketplaceItem(
    product: p,
    sellerRole: "Processor",
    sellerName: "Sahyadri Agro Mill & Processors",
  )),
];