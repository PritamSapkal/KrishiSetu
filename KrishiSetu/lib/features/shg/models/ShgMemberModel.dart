class ShgMemberModel {
  final String id;
  final String name;
  final String phone;
  final String state;
  final String district;
  final String taluka;
  final String village;
  final int age;

  ShgMemberModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.state,
    required this.district,
    required this.taluka,
    required this.village,
    required this.age,
  });

  factory ShgMemberModel.fromJson(Map<String, dynamic> json) {
    return ShgMemberModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      state: json['state'] ?? '',
      district: json['district'] ?? '',
      taluka: json['taluka'] ?? '',
      village: json['village'] ?? '',
      age: (json['age'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'state': state,
      'district': district,
      'taluka': taluka,
      'village': village,
      'age': age,
    };
  }

  ShgMemberModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? state,
    String? district,
    String? taluka,
    String? village,
    int? age,
  }) {
    return ShgMemberModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      state: state ?? this.state,
      district: district ?? this.district,
      taluka: taluka ?? this.taluka,
      village: village ?? this.village,
      age: age ?? this.age,
    );
  }
}