/// id : "6708db421a9c8f2b34a10001"
/// name : "Organic Finger Millet (Ragi)"
/// category : "Raw Millet"
/// description : "High-calcium, sun-dried organic ragi grains collected directly from local member farmers."
/// imageUrl : "https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80"
/// price : 45.0
/// quantity : 1200.0
/// unit : "KG"
/// sellerId : "6708d7211a9c8f2b34a09876"
/// active : true
/// createdAt : "2026-10-11T10:30:00"
/// updatedAt : "2026-10-11T12:00:00"

class ProductModel {
  ProductModel({
    String? id,
    String? name,
    String? category,
    String? description,
    String? imageUrl,
    num? price,
    double? quantity,
    String? unit,
    String? sellerId,
    bool? active,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _category = category;
    _description = description;
    _imageUrl = imageUrl;
    _price = price;
    _quantity = quantity;
    _unit = unit;
    _sellerId = sellerId;
    _active = active;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  ProductModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _category = json['category'];
    _description = json['description'];
    _imageUrl = json['imageUrl'];
    _price = json['price'];
    _quantity = json['quantity'];
    _unit = json['unit'];
    _sellerId = json['sellerId'];
    _active = json['active'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _name;
  String? _category;
  String? _description;
  String? _imageUrl;
  num? _price;
  double? _quantity;
  String? _unit;
  String? _sellerId;
  bool? _active;
  String? _createdAt;
  String? _updatedAt;

  ProductModel copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    String? imageUrl,
    num? price,
    double? quantity,
    String? unit,
    String? sellerId,
    bool? active,
    String? createdAt,
    String? updatedAt,
  }) =>
      ProductModel(
        id: id ?? _id,
        name: name ?? _name,
        category: category ?? _category,
        description: description ?? _description,
        imageUrl: imageUrl ?? _imageUrl,
        price: price ?? _price,
        quantity: quantity ?? _quantity,
        unit: unit ?? _unit,
        sellerId: sellerId ?? _sellerId,
        active: active ?? _active,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;
  String? get name => _name;
  String? get category => _category;
  String? get description => _description;
  String? get imageUrl => _imageUrl;
  num? get price => _price;
  double? get quantity => _quantity;
  String? get unit => _unit;
  String? get sellerId => _sellerId;
  bool? get active => _active;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['category'] = _category;
    map['description'] = _description;
    map['imageUrl'] = _imageUrl;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['unit'] = _unit;
    map['sellerId'] = _sellerId;
    map['active'] = _active;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}