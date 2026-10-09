class ListingModel {
  final String listingId;
  final String produceId;
  final String productName;
  final String grade;
  final double availableVolume;
  final String volumeUnit;
  final double price;
  final String priceUnit;
  final String status;
  final String listedDate;
  final String expiryDate;

  const ListingModel({
    required this.listingId,
    required this.produceId,
    required this.productName,
    required this.grade,
    required this.availableVolume,
    required this.volumeUnit,
    required this.price,
    required this.priceUnit,
    required this.status,
    required this.listedDate,
    required this.expiryDate,
  });
}