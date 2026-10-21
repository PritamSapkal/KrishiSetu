/// token : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmYXJtZXJAZ21haWwuY29tIiwiaWF0IjoxNzkyNTc4OTgxLCJleHAiOjE3OTI1ODI1ODF9.sBVa1ic_CM7KjWXIjUcp-KPiirqTh-vPZJ9bFl7yUUU"
/// message : "Login Successful"
/// user : {"id":"6abe08d8b9e86f93f1989df0","name":"Pritam Sapkal","email":"farmer@gmail.com","phone":"9876543210","role":"FARMER"}

class FarmerAuthModel {
  FarmerAuthModel({
      String? token, 
      String? message, 
      User? user,}){
    _token = token;
    _message = message;
    _user = user;
}

  FarmerAuthModel.fromJson(dynamic json) {
    _token = json['token'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _token;
  String? _message;
  User? _user;
FarmerAuthModel copyWith({  String? token,
  String? message,
  User? user,
}) => FarmerAuthModel(  token: token ?? _token,
  message: message ?? _message,
  user: user ?? _user,
);
  String? get token => _token;
  String? get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// id : "6abe08d8b9e86f93f1989df0"
/// name : "Pritam Sapkal"
/// email : "farmer@gmail.com"
/// phone : "9876543210"
/// role : "FARMER"

class User {
  User({
      String? id, 
      String? name, 
      String? email, 
      String? phone, 
      String? role,}){
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _role = role;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _role = json['role'];
  }
  String? _id;
  String? _name;
  String? _email;
  String? _phone;
  String? _role;
User copyWith({  String? id,
  String? name,
  String? email,
  String? phone,
  String? role,
}) => User(  id: id ?? _id,
  name: name ?? _name,
  email: email ?? _email,
  phone: phone ?? _phone,
  role: role ?? _role,
);
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get role => _role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['role'] = _role;
    return map;
  }

}