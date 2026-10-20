import '../../../core/models/OrderModel.dart';

final List<OrderModel> mockProcessorOrderList = [
  // 1. PENDING - New wholesale bulk intake from Institutional Buyer
  OrderModel(
    id: "6715cd129f1c4e78a2300201",
    buyerId: "6708d7211a9c8f2b34a09899",
    productId: "PRC_PRD_001",
    name: "Industrial Fine Ragi Flour",
    imageUrl: "https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=500&q=80",
    quantity: 25.0,
    unit: "QUINTAL",
    pricePerUnit: 3600.0,
    totalPrice: 90000.0,
    status: OrderStatus.PENDING,
    createdAt: DateTime.parse("2026-10-20T08:30:00"),
    updatedAt: DateTime.parse("2026-10-20T08:30:00"),
  ),

  // 2. CONFIRMED - Accepted order scheduled for dehulling batch
  OrderModel(
    id: "6715cd129f1c4e78a2300202",
    buyerId: "6708d7211a9c8f2b34a09877",
    productId: "PRC_PRD_002",
    name: "Dehulled Foxtail Millet (Kangni)",
    imageUrl: "https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80",
    quantity: 15.0,
    unit: "QUINTAL",
    pricePerUnit: 5800.0,
    totalPrice: 87000.0,
    status: OrderStatus.CONFIRMED,
    createdAt: DateTime.parse("2026-10-19T14:15:00"),
    updatedAt: DateTime.parse("2026-10-19T16:00:00"),
  ),

  // 3. PROCESSING - In milling & mechanical packaging line
  OrderModel(
    id: "6715cd129f1c4e78a2300203",
    buyerId: "6708d7211a9c8f2b34a09888",
    productId: "PRC_PRD_003",
    name: "Processed Jowar Rava (Semolina)",
    imageUrl: "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?auto=format&fit=crop&w=500&q=80",
    quantity: 800.0,
    unit: "KG",
    pricePerUnit: 42.0,
    totalPrice: 33600.0,
    status: OrderStatus.PROCESSING,
    createdAt: DateTime.parse("2026-10-18T10:45:00"),
    updatedAt: DateTime.parse("2026-10-19T09:30:00"),
  ),

  // 4. SHIPPED - Loaded into logistics truck from MIDC Kupwad
  OrderModel(
    id: "6715cd129f1c4e78a2300204",
    buyerId: "6708d7211a9c8f2b34a09866",
    productId: "PRC_PRD_004",
    name: "Steam-Rolled Pearl Millet Flakes",
    imageUrl: "https://images.unsplash.com/photo-1543362906-acfc16c67564?auto=format&fit=crop&w=500&q=80",
    quantity: 500.0,
    unit: "KG",
    pricePerUnit: 65.0,
    totalPrice: 32500.0,
    status: OrderStatus.SHIPPED,
    createdAt: DateTime.parse("2026-10-17T11:00:00"),
    updatedAt: DateTime.parse("2026-10-18T17:00:00"),
  ),

  // 5. DELIVERED - Completed dispatch and received by grain distributor
  OrderModel(
    id: "6715cd129f1c4e78a2300205",
    buyerId: "6708d7211a9c8f2b34a09855",
    productId: "PRC_PRD_005",
    name: "Cleaned & Graded Little Millet",
    imageUrl: "https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80",
    quantity: 20.0,
    unit: "QUINTAL",
    pricePerUnit: 6200.0,
    totalPrice: 124000.0,
    status: OrderStatus.DELIVERED,
    createdAt: DateTime.parse("2026-10-14T09:30:00"),
    updatedAt: DateTime.parse("2026-10-16T15:20:00"),
  ),

  // 6. CANCELLED - Order cancelled due to specification mismatch
  OrderModel(
    id: "6715cd129f1c4e78a2300206",
    buyerId: "6708d7211a9c8f2b34a09844",
    productId: "PRC_PRD_001",
    name: "Industrial Fine Ragi Flour",
    imageUrl: "https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=500&q=80",
    quantity: 10.0,
    unit: "QUINTAL",
    pricePerUnit: 3600.0,
    totalPrice: 36000.0,
    status: OrderStatus.CANCELLED,
    createdAt: DateTime.parse("2026-10-13T13:00:00"),
    updatedAt: DateTime.parse("2026-10-13T14:15:00"),
  ),
];