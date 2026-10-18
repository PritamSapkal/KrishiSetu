import '../models/SHG_AuthModel.dart';
import '../models/SHG_ProfileModel.dart';

class MockShgData {
  // 1. Mock SHG Login Response
  static final ShgAuthModel mockShgAuth = ShgAuthModel(
    token:
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJTaGdAZ21haWwuY29tIiwiaWF0IjoxNzkyMzIxMjQ5LCJleHAiOjE3OTIzMjQ4NDl9.yRILpJfU-WEbAy11OKe_nBDe2Ejde-8o_dp4gp3nrWE",
    message: "Login Successful",
    user: User(
      id: "6abe093fb9e86f93f1989df2",
      name: "Pritam Sapkal",
      email: "Shg@gmail.com",
      phone: "9876543210",
      role: "SHG",
    ),
  );

  // 2. Mock SHG Group Profile
  static final ShgProfileModel mockShgProfile = ShgProfileModel(
    id: "6abe0d16b9e86f93f1989df7",
    userId: "6abe093fb9e86f93f1989df2",
    shgName: "Mahila Samruddhi Bachat Gat",
    groupRegistrationNumber: "SHG-MH-2024-00456",
    numberOfMembers: 12,
    primaryActivity: "MILLET_PROCESSING",
    village: "Tasgaon",
    taluka: "Tasgaon",
    district: "Sangli",
    state: "Maharashtra",
  );
}