import '../models/FarmerAuthModel.dart';
import '../models/FarmerProfieModel.dart';

class MockFarmerData {
  // 1. Mock Farmer Login / Auth Data
  static final FarmerAuthModel mockFarmerAuth = FarmerAuthModel(
    token:
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmYXJtZXJAZ21haWwuY29tIiwiaWF0IjoxNzkyNTc4OTgxLCJleHAiOjE3OTI1ODI1ODF9.sBVa1ic_CM7KjWXIjUcp-KPiirqTh-vPZJ9bFl7yUUU",
    message: "Login Successful",
    user: User(
      id: "6abe08d8b9e86f93f1989df0",
      name: "Pritam Sapkal",
      email: "farmer@gmail.com",
      phone: "9876543210",
      role: "FARMER",
    ),
  );

  // 2. Mock Farmer Profile Data
  static final FarmerProfieModel mockFarmerProfile = FarmerProfieModel(
    id: "6abe0adbb9e86f93f1989df5",
    userId: "6abe08d8b9e86f93f1989df0",
    farmSize: 1.0,
    farmSizeUnit: "ACRE",
    milletCrops: ["JOWAR", "BAJRA", "RAGI"],
    village: "Sangli",
    taluka: "Miraj",
    district: "Sangli",
    state: "Maharashtra",
  );
}