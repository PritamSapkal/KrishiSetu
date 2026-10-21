/// district : "Sangli"
/// farmSize : 1.0
/// farmSizeUnit : "ACRE"
/// id : "6abe0adbb9e86f93f1989df5"
/// milletCrops : ["JOWAR"]
/// state : "Maharashtra"
/// taluka : "Miraj"
/// userId : "6abe08d8b9e86f93f1989df0"
/// village : "Sangli"

class FarmerProfieModel {
  FarmerProfieModel({
      String? district, 
      num? farmSize, 
      String? farmSizeUnit, 
      String? id, 
      List<String>? milletCrops, 
      String? state, 
      String? taluka, 
      String? userId, 
      String? village,}){
    _district = district;
    _farmSize = farmSize;
    _farmSizeUnit = farmSizeUnit;
    _id = id;
    _milletCrops = milletCrops;
    _state = state;
    _taluka = taluka;
    _userId = userId;
    _village = village;
}

  FarmerProfieModel.fromJson(dynamic json) {
    _district = json['district'];
    _farmSize = json['farmSize'];
    _farmSizeUnit = json['farmSizeUnit'];
    _id = json['id'];
    _milletCrops = json['milletCrops'] != null ? json['milletCrops'].cast<String>() : [];
    _state = json['state'];
    _taluka = json['taluka'];
    _userId = json['userId'];
    _village = json['village'];
  }
  String? _district;
  num? _farmSize;
  String? _farmSizeUnit;
  String? _id;
  List<String>? _milletCrops;
  String? _state;
  String? _taluka;
  String? _userId;
  String? _village;
FarmerProfieModel copyWith({  String? district,
  num? farmSize,
  String? farmSizeUnit,
  String? id,
  List<String>? milletCrops,
  String? state,
  String? taluka,
  String? userId,
  String? village,
}) => FarmerProfieModel(  district: district ?? _district,
  farmSize: farmSize ?? _farmSize,
  farmSizeUnit: farmSizeUnit ?? _farmSizeUnit,
  id: id ?? _id,
  milletCrops: milletCrops ?? _milletCrops,
  state: state ?? _state,
  taluka: taluka ?? _taluka,
  userId: userId ?? _userId,
  village: village ?? _village,
);
  String? get district => _district;
  num? get farmSize => _farmSize;
  String? get farmSizeUnit => _farmSizeUnit;
  String? get id => _id;
  List<String>? get milletCrops => _milletCrops;
  String? get state => _state;
  String? get taluka => _taluka;
  String? get userId => _userId;
  String? get village => _village;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['district'] = _district;
    map['farmSize'] = _farmSize;
    map['farmSizeUnit'] = _farmSizeUnit;
    map['id'] = _id;
    map['milletCrops'] = _milletCrops;
    map['state'] = _state;
    map['taluka'] = _taluka;
    map['userId'] = _userId;
    map['village'] = _village;
    return map;
  }

}