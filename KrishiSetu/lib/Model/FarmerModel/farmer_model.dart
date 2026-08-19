class FarmerContributionModel {
  final double value;
  final String unit;

  const FarmerContributionModel({
    required this.value,
    required this.unit,
  });
}

class FarmerModel {
  final String farmerId;
  final String fullName;
  final String mobileNumber;
  final String pinCode;
  final String village;
  final String district;
  final String memberSince;
  final List<String> primaryCrops;
  final double farmSize;
  final String farmSizeUnit;
  final FarmerContributionModel currentContribution;

  const FarmerModel({
    required this.farmerId,
    required this.fullName,
    required this.mobileNumber,
    required this.pinCode,
    required this.village,
    required this.district,
    required this.memberSince,
    required this.primaryCrops,
    required this.farmSize,
    required this.farmSizeUnit,
    required this.currentContribution,
  });
}