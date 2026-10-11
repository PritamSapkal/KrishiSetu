/// token : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJCdXllckBnbWFpbC5jb20iLCJpYXQiOjE3OTE3MTA0NjIsImV4cCI6MTc5MTcxNDA2Mn0.s3Z10qJiclElMlIl0HaXHzugWHl1SWHwLhyT0U5Od-c"
/// message : "Login Successful"
/// user : {"id":"6abe098cb9e86f93f1989df4","name":"Pritam Sapkal","email":"Buyer@gmail.com","phone":"9876543210","role":"BUYER"}

class FpoAuthModel {
  FpoAuthModel({
      String? token, 
      String? message, 
      User? user,}){
    _token = token;
    _message = message;
    _user = user;
}

  FpoAuthModel.fromJson(dynamic json) {
    _token = json['token'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _token;
  String? _message;
  User? _user;
FpoAuthModel copyWith({  String? token,
  String? message,
  User? user,
}) => FpoAuthModel(  token: token ?? _token,
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

/// id : "6abe098cb9e86f93f1989df4"
/// name : "Pritam Sapkal"
/// email : "Buyer@gmail.com"
/// phone : "9876543210"
/// role : "BUYER"

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