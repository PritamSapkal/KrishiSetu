class OrderBuyerModel {
  final String buyerId;
  final String name;

  const OrderBuyerModel({
    required this.buyerId,
    required this.name,
  });
}

class OrderProductModel {
  final String produceId;
  final String name;
  final String image;
  final String grade;

  const OrderProductModel({
    required this.produceId,
    required this.name,
    required this.image,
    required this.grade,
  });
}

class OrderModel {
  final String orderId;
  final OrderBuyerModel buyer;
  final OrderProductModel product;
  final double quantity;
  final String quantityUnit;
  final double totalAmount;
  final String status;
  final String orderDate;
  final String dueDate;
  final String paymentStatus;

  const OrderModel({
    required this.orderId,
    required this.buyer,
    required this.product,
    required this.quantity,
    required this.quantityUnit,
    required this.totalAmount,
    required this.status,
    required this.orderDate,
    required this.dueDate,
    required this.paymentStatus,
  });
}