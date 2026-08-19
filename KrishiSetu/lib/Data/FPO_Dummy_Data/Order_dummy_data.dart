import '../../Model/FarmerModel/OrderModel.dart';

final List<OrderModel> orderslist = [
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

  OrderModel(
    orderId: "ORD1002",
    buyer: OrderBuyerModel(
      buyerId: "BUY002",
      name: "AgroTrade India Pvt. Ltd.",
    ),
    product: OrderProductModel(
      produceId: "PROD002",
      name: "Soybean",
      image: "assets/images/soybean.png",
      grade: "Grade A",
    ),
    quantity: 8,
    quantityUnit: "tons",
    totalAmount: 368000,
    status: "Active",
    orderDate: "16 August 2026",
    dueDate: "24 August 2026",
    paymentStatus: "Pending",
  ),

  OrderModel(
    orderId: "ORD1003",
    buyer: OrderBuyerModel(
      buyerId: "BUY003",
      name: "Maharashtra Agro Foods",
    ),
    product: OrderProductModel(
      produceId: "PROD003",
      name: "Wheat",
      image: "assets/images/wheat.png",
      grade: "Grade A",
    ),
    quantity: 10,
    quantityUnit: "tons",
    totalAmount: 265000,
    status: "Completed",
    orderDate: "08 August 2026",
    dueDate: "15 August 2026",
    paymentStatus: "Paid",
  ),

  OrderModel(
    orderId: "ORD1004",
    buyer: OrderBuyerModel(
      buyerId: "BUY004",
      name: "GreenBasket Retail Pvt. Ltd.",
    ),
    product: OrderProductModel(
      produceId: "PROD004",
      name: "Tur Dal",
      image: "assets/images/tur_dal.png",
      grade: "Premium",
    ),
    quantity: 4,
    quantityUnit: "tons",
    totalAmount: 420000,
    status: "Active",
    orderDate: "14 August 2026",
    dueDate: "22 August 2026",
    paymentStatus: "Partially Paid",
  ),

  OrderModel(
    orderId: "ORD1005",
    buyer: OrderBuyerModel(
      buyerId: "BUY005",
      name: "National Food Traders",
    ),
    product: OrderProductModel(
      produceId: "PROD005",
      name: "Maize",
      image: "assets/images/maize.png",
      grade: "Grade B",
    ),
    quantity: 7,
    quantityUnit: "tons",
    totalAmount: 126000,
    status: "Cancelled",
    orderDate: "10 August 2026",
    dueDate: "18 August 2026",
    paymentStatus: "Refunded",
  ),
];