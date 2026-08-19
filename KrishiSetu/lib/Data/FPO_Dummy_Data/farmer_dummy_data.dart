

import '../../Model/FarmerModel/farmer_model.dart';

final List<FarmerModel> farmers = [
  FarmerModel(
    farmerId: "FMR001",
    fullName: "Ramesh Patil",
    mobileNumber: "9876543210",
    pinCode: "416416",
    village: "Miraj",
    district: "Sangli",
    memberSince: "12 June 2024",
    primaryCrops: [
      "Onion",
      "Sugarcane",
    ],
    farmSize: 6.5,
    farmSizeUnit: "acres",
    currentContribution: FarmerContributionModel(
      value: 4.5,
      unit: "tons",
    ),
  ),

  FarmerModel(
    farmerId: "FMR002",
    fullName: "Suresh Jadhav",
    mobileNumber: "9876543211",
    pinCode: "416416",
    village: "Tasgaon",
    district: "Sangli",
    memberSince: "04 March 2025",
    primaryCrops: [
      "Soybean",
      "Wheat",
    ],
    farmSize: 8.0,
    farmSizeUnit: "acres",
    currentContribution: FarmerContributionModel(
      value: 6.0,
      unit: "tons",
    ),
  ),

  FarmerModel(
    farmerId: "FMR003",
    fullName: "Vijay Mane",
    mobileNumber: "9876543212",
    pinCode: "416308",
    village: "Kavathe Mahankal",
    district: "Sangli",
    memberSince: "18 January 2025",
    primaryCrops: [
      "Onion",
      "Tur",
    ],
    farmSize: 5.5,
    farmSizeUnit: "acres",
    currentContribution: FarmerContributionModel(
      value: 3.2,
      unit: "tons",
    ),
  ),
];