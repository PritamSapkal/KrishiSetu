import '../../Model/FarmerModel/OrderModel.dart';

final List<OrderModel> orders = [
  OrderModel(
    orderId: "ORD1001",
    buyer: OrderBuyerModel(
      buyerId: "BUY001",
      name: "FreshMart Foods Pvt. Ltd.",
    ),
    product: OrderProductModel(
      produceId: "PROD001",
      name: "Onion",
      image: "assets/images/onion.png",
      grade: "Grade A",
    ),
    quantity: 5,
    quantityUnit: "tons",
    totalAmount: 140000,
    status: "New",
    orderDate: "18 August 2026",
    dueDate: "25 August 2026",
    paymentStatus: "Pending",
  ),
];