import '../../Model/FarmerModel/produce_model.dart';

final List<ProduceModel> produces = [
  ProduceModel(
    produceId: "PROD001",
    name: "Onion",
    image: "assets/images/onion.png",
    grade: "Grade A",
    volume: 8.5,
    volumeUnit: "tons",
    contributingFarmers: 18,
    status: "Available",
    details: ProduceDetailsModel(
      variety: "Red Onion",
      harvestSeason: "Rabi",
      averagePrice: 2800,
      priceUnit: "per quintal",
      storageLocation: "Sangli FPO Warehouse",
      storageCapacity: 50,
      storageUnit: "tons",
    ),
  ),

  ProduceModel(
    produceId: "PROD002",
    name: "Soybean",
    image: "assets/images/soybean.png",
    grade: "Grade A",
    volume: 12.0,
    volumeUnit: "tons",
    contributingFarmers: 25,
    status: "Available",
    details: ProduceDetailsModel(
      variety: "JS 335",
      harvestSeason: "Kharif",
      averagePrice: 4600,
      priceUnit: "per quintal",
      storageLocation: "Sangli FPO Warehouse",
      storageCapacity: 50,
      storageUnit: "tons",
    ),
  ),
];