/// address : "Gat No. 142, MIDC Kupwad"
/// businessName : "Sahyadri Agro Processing Enterprise"
/// businessRegistrationNumber : "UDYAM-MH-31-0012456"
/// businessType : "Private Limited"
/// district : "Sangli"
/// gstNumber : "27AAACS1429B1Z8"
/// id : "6abe0db0b9e86f93f1989df8"
/// processingActivities : ["CLEANING","GRADING","MILLING","PACKAGING"]
/// state : "Maharashtra"
/// userId : "6abe0966b9e86f93f1989df3"
/// villageOrCity : "Sangli"

class ProcessorProfileModel {
  ProcessorProfileModel({
      String? address, 
      String? businessName, 
      String? businessRegistrationNumber, 
      String? businessType, 
      String? district, 
      String? gstNumber, 
      String? id, 
      List<String>? processingActivities, 
      String? state, 
      String? userId, 
      String? villageOrCity,}){
    _address = address;
    _businessName = businessName;
    _businessRegistrationNumber = businessRegistrationNumber;
    _businessType = businessType;
    _district = district;
    _gstNumber = gstNumber;
    _id = id;
    _processingActivities = processingActivities;
    _state = state;
    _userId = userId;
    _villageOrCity = villageOrCity;
}

  ProcessorProfileModel.fromJson(dynamic json) {
    _address = json['address'];
    _businessName = json['businessName'];
    _businessRegistrationNumber = json['businessRegistrationNumber'];
    _businessType = json['businessType'];
    _district = json['district'];
    _gstNumber = json['gstNumber'];
    _id = json['id'];
    _processingActivities = json['processingActivities'] != null ? json['processingActivities'].cast<String>() : [];
    _state = json['state'];
    _userId = json['userId'];
    _villageOrCity = json['villageOrCity'];
  }
  String? _address;
  String? _businessName;
  String? _businessRegistrationNumber;
  String? _businessType;
  String? _district;
  String? _gstNumber;
  String? _id;
  List<String>? _processingActivities;
  String? _state;
  String? _userId;
  String? _villageOrCity;
ProcessorProfileModel copyWith({  String? address,
  String? businessName,
  String? businessRegistrationNumber,
  String? businessType,
  String? district,
  String? gstNumber,
  String? id,
  List<String>? processingActivities,
  String? state,
  String? userId,
  String? villageOrCity,
}) => ProcessorProfileModel(  address: address ?? _address,
  businessName: businessName ?? _businessName,
  businessRegistrationNumber: businessRegistrationNumber ?? _businessRegistrationNumber,
  businessType: businessType ?? _businessType,
  district: district ?? _district,
  gstNumber: gstNumber ?? _gstNumber,
  id: id ?? _id,
  processingActivities: processingActivities ?? _processingActivities,
  state: state ?? _state,
  userId: userId ?? _userId,
  villageOrCity: villageOrCity ?? _villageOrCity,
);
  String? get address => _address;
  String? get businessName => _businessName;
  String? get businessRegistrationNumber => _businessRegistrationNumber;
  String? get businessType => _businessType;
  String? get district => _district;
  String? get gstNumber => _gstNumber;
  String? get id => _id;
  List<String>? get processingActivities => _processingActivities;
  String? get state => _state;
  String? get userId => _userId;
  String? get villageOrCity => _villageOrCity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['businessName'] = _businessName;
    map['businessRegistrationNumber'] = _businessRegistrationNumber;
    map['businessType'] = _businessType;
    map['district'] = _district;
    map['gstNumber'] = _gstNumber;
    map['id'] = _id;
    map['processingActivities'] = _processingActivities;
    map['state'] = _state;
    map['userId'] = _userId;
    map['villageOrCity'] = _villageOrCity;
    return map;
  }

}