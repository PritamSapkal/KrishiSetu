class ProduceDetailsModel {
  final String variety;
  final String harvestSeason;
  final double averagePrice;
  final String priceUnit;
  final String storageLocation;
  final double storageCapacity;
  final String storageUnit;

  const ProduceDetailsModel({
    required this.variety,
    required this.harvestSeason,
    required this.averagePrice,
    required this.priceUnit,
    required this.storageLocation,
    required this.storageCapacity,
    required this.storageUnit,
  });
}

class ProduceModel {
  final String produceId;
  final String name;
  final String image;
  final String grade;
  final double volume;
  final String volumeUnit;
  final int contributingFarmers;
  final String status;
  final ProduceDetailsModel details;

  const ProduceModel({
    required this.produceId,
    required this.name,
    required this.image,
    required this.grade,
    required this.volume,
    required this.volumeUnit,
    required this.contributingFarmers,
    required this.status,
    required this.details,
  });
}