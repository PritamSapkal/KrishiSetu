import '../models/FpoAuthModel.dart';
import '../models/FpoProfileModel.dart';


class MockFpoData {
  // 1. Mock Login/Auth Response
  static final FpoAuthModel mockFpoAuth = FpoAuthModel(
    token: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJrcmlzaGl2aWthcy5mcG9AZ21haWwuY29tIiwiaWF0IjoxNzkxNzEwNDYyLCJleHAiOjE3OTE3MTQwNjJ9.s3Z10qJiclElMlIl0HaXHzugWHl1SWHwLhyT0U5Od-c",
    message: "Login Successful",
    user: User(
      id: "6abe0919b9e86f93f1989df1",
      name: "Ramesh Kadam (Director)",
      email: "krishivikas.fpo@gmail.com",
      phone: "9822334455",
      role: "FPO",
    ),
  );

  // 2. Mock FPO Business Profile
  static final FpoProfileModel mockFpoProfile = FpoProfileModel(
    id: "6abe0c1fb9e86f93f1989df6",
    userId: "6abe0919b9e86f93f1989df1", // Matches the User ID above
    fpoName: "Krishi Vikas Producer Company Ltd",
    registrationNumber: "FPO-MH-2024-00123",
    numberOfFarmers: 250,
    village: "Palus",
    taluka: "Palus",
    district: "Sangli",
    state: "Maharashtra",
  );
}