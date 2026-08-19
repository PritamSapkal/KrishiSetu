import '../../Model/FarmerModel/listing_model.dart';

final List<ListingModel> listings = [
  ListingModel(
    listingId: "LST001",
    produceId: "PROD001",
    productName: "Onion",
    grade: "Grade A",
    availableVolume: 5.0,
    volumeUnit: "tons",
    price: 2800,
    priceUnit: "per quintal",
    status: "Active",
    listedDate: "18 August 2026",
    expiryDate: "30 August 2026",
  ),

  ListingModel(
    listingId: "LST002",
    produceId: "PROD002",
    productName: "Soybean",
    grade: "Grade A",
    availableVolume: 7.5,
    volumeUnit: "tons",
    price: 4600,
    priceUnit: "per quintal",
    status: "Active",
    listedDate: "17 August 2026",
    expiryDate: "28 August 2026",
  ),
];