/// district : "Sangli"
/// groupRegistrationNumber : "SHG-MH-2024-00456"
/// id : "6abe0d16b9e86f93f1989df7"
/// numberOfMembers : 12
/// primaryActivity : "MILLET_PROCESSING"
/// shgName : "Mahila Samruddhi Bachat Gat"
/// state : "Maharashtra"
/// taluka : "Tasgaon"
/// userId : "6abe093fb9e86f93f1989df2"
/// village : "Tasgaon"

class ShgProfileModel {
  ShgProfileModel({
      String? district, 
      String? groupRegistrationNumber, 
      String? id, 
      num? numberOfMembers, 
      String? primaryActivity, 
      String? shgName, 
      String? state, 
      String? taluka, 
      String? userId, 
      String? village,}){
    _district = district;
    _groupRegistrationNumber = groupRegistrationNumber;
    _id = id;
    _numberOfMembers = numberOfMembers;
    _primaryActivity = primaryActivity;
    _shgName = shgName;
    _state = state;
    _taluka = taluka;
    _userId = userId;
    _village = village;
}

  ShgProfileModel.fromJson(dynamic json) {
    _district = json['district'];
    _groupRegistrationNumber = json['groupRegistrationNumber'];
    _id = json['id'];
    _numberOfMembers = json['numberOfMembers'];
    _primaryActivity = json['primaryActivity'];
    _shgName = json['shgName'];
    _state = json['state'];
    _taluka = json['taluka'];
    _userId = json['userId'];
    _village = json['village'];
  }
  String? _district;
  String? _groupRegistrationNumber;
  String? _id;
  num? _numberOfMembers;
  String? _primaryActivity;
  String? _shgName;
  String? _state;
  String? _taluka;
  String? _userId;
  String? _village;
ShgProfileModel copyWith({  String? district,
  String? groupRegistrationNumber,
  String? id,
  num? numberOfMembers,
  String? primaryActivity,
  String? shgName,
  String? state,
  String? taluka,
  String? userId,
  String? village,
}) => ShgProfileModel(  district: district ?? _district,
  groupRegistrationNumber: groupRegistrationNumber ?? _groupRegistrationNumber,
  id: id ?? _id,
  numberOfMembers: numberOfMembers ?? _numberOfMembers,
  primaryActivity: primaryActivity ?? _primaryActivity,
  shgName: shgName ?? _shgName,
  state: state ?? _state,
  taluka: taluka ?? _taluka,
  userId: userId ?? _userId,
  village: village ?? _village,
);
  String? get district => _district;
  String? get groupRegistrationNumber => _groupRegistrationNumber;
  String? get id => _id;
  num? get numberOfMembers => _numberOfMembers;
  String? get primaryActivity => _primaryActivity;
  String? get shgName => _shgName;
  String? get state => _state;
  String? get taluka => _taluka;
  String? get userId => _userId;
  String? get village => _village;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['district'] = _district;
    map['groupRegistrationNumber'] = _groupRegistrationNumber;
    map['id'] = _id;
    map['numberOfMembers'] = _numberOfMembers;
    map['primaryActivity'] = _primaryActivity;
    map['shgName'] = _shgName;
    map['state'] = _state;
    map['taluka'] = _taluka;
    map['userId'] = _userId;
    map['village'] = _village;
    return map;
  }

}