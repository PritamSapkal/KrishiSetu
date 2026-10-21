import '../../../core/models/OrderModel.dart';

final List<OrderModel> mockFarmerOrderList = [
  // 1. PENDING - Fresh harvest order placed by a local FPO/Buyer
  OrderModel(
    id: "6718ef129f1c4e78a2300301",
    buyerId: "6708d7211a9c8f2b34a09899",
    productId: "FAR_PRD_001",
    name: "Raw Maldandi Jowar (Sorghum)",
    imageUrl: "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?auto=format&fit=crop&w=500&q=80",
    quantity: 15.0,
    unit: "QUINTAL",
    pricePerUnit: 3400.0,
    totalPrice: 51000.0,
    status: OrderStatus.PENDING,
    createdAt: DateTime.parse("2026-10-21T09:30:00"),
    updatedAt: DateTime.parse("2026-10-21T09:30:00"),
  ),

  // 2. CONFIRMED - Accepted order for Sun-Dried Ragi (Finger Millet)
  OrderModel(
    id: "6718ef129f1c4e78a2300302",
    buyerId: "6708d7211a9c8f2b34a09877",
    productId: "FAR_PRD_002",
    name: "Farm Fresh Ragi (Finger Millet)",
    imageUrl: "https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80",
    quantity: 500.0,
    unit: "KG",
    pricePerUnit: 42.0,
    totalPrice: 21000.0,
    status: OrderStatus.CONFIRMED,
    createdAt: DateTime.parse("2026-10-20T14:15:00"),
    updatedAt: DateTime.parse("2026-10-20T16:00:00"),
  ),

  // 3. PROCESSING - In threshing & bagging stage for Bajra
  OrderModel(
    id: "6718ef129f1c4e78a2300303",
    buyerId: "6708d7211a9c8f2b34a09888",
    productId: "FAR_PRD_003",
    name: "Organic Pearl Millet (Bajra)",
    imageUrl: "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?auto=format&fit=crop&w=500&q=80",
    quantity: 8.0,
    unit: "QUINTAL",
    pricePerUnit: 2800.0,
    totalPrice: 22400.0,
    status: OrderStatus.PROCESSING,
    createdAt: DateTime.parse("2026-10-19T10:00:00"),
    updatedAt: DateTime.parse("2026-10-20T08:30:00"),
  ),

  // 4. SHIPPED - Loaded onto tractor trolley for APMC delivery
  OrderModel(
    id: "6718ef129f1c4e78a2300304",
    buyerId: "6708d7211a9c8f2b34a09866",
    productId: "FAR_PRD_004",
    name: "Unpolished Foxtail Millet (Kangni)",
    imageUrl: "https://images.unsplash.com/photo-1543362906-acfc16c67564?auto=format&fit=crop&w=500&q=80",
    quantity: 300.0,
    unit: "KG",
    pricePerUnit: 60.0,
    totalPrice: 18000.0,
    status: OrderStatus.SHIPPED,
    createdAt: DateTime.parse("2026-10-18T11:20:00"),
    updatedAt: DateTime.parse("2026-10-19T15:40:00"),
  ),

  // 5. DELIVERED - Completed dispatch and payment received
  OrderModel(
    id: "6718ef129f1c4e78a2300305",
    buyerId: "6708d7211a9c8f2b34a09855",
    productId: "FAR_PRD_005",
    name: "Golden Little Millet (Kutki)",
    imageUrl: "https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80",
    quantity: 10.0,
    unit: "QUINTAL",
    pricePerUnit: 5200.0,
    totalPrice: 52000.0,
    status: OrderStatus.DELIVERED,
    createdAt: DateTime.parse("2026-10-15T08:45:00"),
    updatedAt: DateTime.parse("2026-10-17T12:00:00"),
  ),

  // 6. CANCELLED - Order cancelled by buyer due to moisture requirements
  OrderModel(
    id: "6718ef129f1c4e78a2300306",
    buyerId: "6708d7211a9c8f2b34a09844",
    productId: "FAR_PRD_001",
    name: "Raw Maldandi Jowar (Sorghum)",
    imageUrl: "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?auto=format&fit=crop&w=500&q=80",
    quantity: 5.0,
    unit: "QUINTAL",
    pricePerUnit: 3400.0,
    totalPrice: 17000.0,
    status: OrderStatus.CANCELLED,
    createdAt: DateTime.parse("2026-10-14T13:10:00"),
    updatedAt: DateTime.parse("2026-10-14T14:00:00"),
  ),
];