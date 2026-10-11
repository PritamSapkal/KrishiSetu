/// district : "Sangli"
/// fpoName : "Krishi Vikas Producer Company Ltd"
/// id : "6abe0c1fb9e86f93f1989df6"
/// numberOfFarmers : 250
/// registrationNumber : "FPO-MH-2024-00123"
/// state : "Maharashtra"
/// taluka : "Palus"
/// userId : "6abe0919b9e86f93f1989df1"
/// village : "Palus"

class FpoProfileModel {
  FpoProfileModel({
      String? district, 
      String? fpoName, 
      String? id, 
      num? numberOfFarmers, 
      String? registrationNumber, 
      String? state, 
      String? taluka, 
      String? userId, 
      String? village,}){
    _district = district;
    _fpoName = fpoName;
    _id = id;
    _numberOfFarmers = numberOfFarmers;
    _registrationNumber = registrationNumber;
    _state = state;
    _taluka = taluka;
    _userId = userId;
    _village = village;
}

  FpoProfileModel.fromJson(dynamic json) {
    _district = json['district'];
    _fpoName = json['fpoName'];
    _id = json['id'];
    _numberOfFarmers = json['numberOfFarmers'];
    _registrationNumber = json['registrationNumber'];
    _state = json['state'];
    _taluka = json['taluka'];
    _userId = json['userId'];
    _village = json['village'];
  }
  String? _district;
  String? _fpoName;
  String? _id;
  num? _numberOfFarmers;
  String? _registrationNumber;
  String? _state;
  String? _taluka;
  String? _userId;
  String? _village;
FpoProfileModel copyWith({  String? district,
  String? fpoName,
  String? id,
  num? numberOfFarmers,
  String? registrationNumber,
  String? state,
  String? taluka,
  String? userId,
  String? village,
}) => FpoProfileModel(  district: district ?? _district,
  fpoName: fpoName ?? _fpoName,
  id: id ?? _id,
  numberOfFarmers: numberOfFarmers ?? _numberOfFarmers,
  registrationNumber: registrationNumber ?? _registrationNumber,
  state: state ?? _state,
  taluka: taluka ?? _taluka,
  userId: userId ?? _userId,
  village: village ?? _village,
);
  String? get district => _district;
  String? get fpoName => _fpoName;
  String? get id => _id;
  num? get numberOfFarmers => _numberOfFarmers;
  String? get registrationNumber => _registrationNumber;
  String? get state => _state;
  String? get taluka => _taluka;
  String? get userId => _userId;
  String? get village => _village;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['district'] = _district;
    map['fpoName'] = _fpoName;
    map['id'] = _id;
    map['numberOfFarmers'] = _numberOfFarmers;
    map['registrationNumber'] = _registrationNumber;
    map['state'] = _state;
    map['taluka'] = _taluka;
    map['userId'] = _userId;
    map['village'] = _village;
    return map;
  }

}