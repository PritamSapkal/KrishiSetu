enum OrderStatus {
  PENDING,
  CONFIRMED,
  PROCESSING,
  SHIPPED,
  DELIVERED,
  CANCELLED;

  static OrderStatus fromString(String? value) {
    return OrderStatus.values.firstWhere(
          (e) => e.name.toUpperCase() == (value ?? '').toUpperCase(),
      orElse: () => OrderStatus.PENDING,
    );
  }
}

class OrderModel {
  final String id;
  final String buyerId;
  final String productId;
  final String imageUrl;
  final double quantity;
  final String unit;
  final double pricePerUnit;
  final double totalPrice;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  OrderModel({
    required this.id,
    required this.buyerId,
    required this.productId,
    required this.imageUrl,
    required this.quantity,
    required this.unit,
    required this.pricePerUnit,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      buyerId: json['buyerId'] ?? '',
      name: json['name'] ?? '',
      productId: json['productId'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit'] ?? '',
      pricePerUnit: (json['pricePerUnit'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      status: OrderStatus.fromString(json['status']),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyerId': buyerId,
      'productId': productId,
      'imageUrl': imageUrl,
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'pricePerUnit': pricePerUnit,
      'totalPrice': totalPrice,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  OrderModel copyWith({
    String? id,
    String? buyerId,
    String? productId,
    String? name,
    String? imageUrl,
    double? quantity,
    String? unit,
    double? pricePerUnit,
    double? totalPrice,
    OrderStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      name: name ?? this.name,
      productId: productId ?? this.productId,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      pricePerUnit: pricePerUnit ?? this.pricePerUnit,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}