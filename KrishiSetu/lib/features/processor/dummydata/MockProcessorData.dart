import '../models/ProcessorAuthModel.dart';
import '../models/ProcessorProfileModel.dart';

class MockProcessorData {
  // 1. Mock Processor Login / Auth Data
  static final ProcessorAuthModel mockProcessorAuth = ProcessorAuthModel(
    token:
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJQcm9jZXNzb3JAZ21haWwuY29tIiwiaWF0IjoxNzkyNTE3NTk1LCJleHAiOjE3OTI1MjExOTV9.q1BASG7OQ6iP7lTs4VafYCGNNMzGplYkg9DFZKqu9KI",
    message: "Login Successful",
    user: User(
      id: "6abe0966b9e86f93f1989df3",
      name: "Pritam Sapkal",
      email: "Processor@gmail.com",
      phone: "9876543210",
      role: "PROCESSOR",
    ),
  );

  // 2. Mock Processor Business & Plant Profile Data
  static final ProcessorProfileModel mockProcessorProfile =
  ProcessorProfileModel(
    id: "6abe0db0b9e86f93f1989df8",
    userId: "6abe0966b9e86f93f1989df3",
    businessName: "Sahyadri Agro Processing Enterprise",
    businessType: "Private Limited",
    businessRegistrationNumber: "UDYAM-MH-31-0012456",
    gstNumber: "27AAACS1429B1Z8",
    processingActivities: [
      "CLEANING",
      "GRADING",
      "MILLING",
      "PACKAGING",
    ],
    address: "Gat No. 142, MIDC Kupwad",
    villageOrCity: "Sangli",
    district: "Sangli",
    state: "Maharashtra",
  );
}