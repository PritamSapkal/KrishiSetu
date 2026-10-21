import '../../../core/models/OrderModel.dart'; // Adjust import path if needed

final List<OrderModel> mockShgOrderList = [
  // 1. PENDING - Newly received order for Roasted Millet Flour packs
  OrderModel(
    id: "6712abku345129f1c4e78a2300101",
    buyerId: "6708d7211a9c8f2b34a09899",
    productId: "SHG_PRD_001",
    name: "Roasted Millet Flour Mix",
    imageUrl: "https://www.dineshflourmills.com/cdn/shop/files/Multi_Millets_Flour_Shopify_1.png?v=1788590953",
    quantity: 40.0,
    unit: "PACKS",
    pricePerUnit: 85.0,
    totalPrice: 3400.0,
    status: OrderStatus.PENDING,
    createdAt: DateTime.parse("2026-10-18T10:15:00"),
    updatedAt: DateTime.parse("2026-10-18T10:15:00"),
  ),

  // 2. CONFIRMED - Accepted order for Handmade Ragi Papad
  OrderModel(
    id: "6712ab129f1c4e78a23f65400102",
    buyerId: "6708d7211a9c8f2b34a09877",
    productId: "SHG_PRD_002",
    name: "Handmade Ragi Papad (1kg Box)",
    imageUrl: "https://s3revive-prod-public.s3.ap-south-1.amazonaws.com/uploads/tsp/assets/a377ebb5-3ddc-4fd8-8f63-f4ce9d4426a7.jpg",
    quantity: 60.0,
    unit: "PACKS",
    pricePerUnit: 120.0,
    totalPrice: 7200.0,
    status: OrderStatus.CONFIRMED,
    createdAt: DateTime.parse("2026-10-17T14:30:00"),
    updatedAt: DateTime.parse("2026-10-17T16:00:00"),
  ),

  // 3. PROCESSING - In packaging stage for Organic Bajra Ladoo batch
  OrderModel(
    id: "6712ab129f1cxft4564e78a2300103",
    buyerId: "6708d7211a9c8f2b34a09888",
    productId: "SHG_PRD_003",
    name: "Organic Bajra Ladoo (Jaggery)",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2HImeJeJF3JYN60iD8rCQ9io5xfXFBKbwZTaqtz_PkQ&s=10",
    quantity: 35.0,
    unit: "KG",
    pricePerUnit: 240.0,
    totalPrice: 8400.0,
    status: OrderStatus.PROCESSING,
    createdAt: DateTime.parse("2026-10-16T11:45:00"),
    updatedAt: DateTime.parse("2026-10-17T09:20:00"),
  ),

  // 4. SHIPPED - Dispatched via local transport for wholesale Buyer
  OrderModel(
    id: "6712ab12fgh5769f1c4e78a2300104",
    buyerId: "6708d7211a9c8f2b34a09866",
    productId: "SHG_PRD_004",
    name: "Stone-Ground Jowar Flour",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr_NOu_1dsIJAXDU09bzU40L-cFsx6QUB32ocBYoksoKEaPLp23ZkZ5Wo&s=10",
    quantity: 200.0,
    unit: "KG",
    pricePerUnit: 48.0,
    totalPrice: 9600.0,
    status: OrderStatus.SHIPPED,
    createdAt: DateTime.parse("2026-10-15T09:00:00"),
    updatedAt: DateTime.parse("2026-10-16T17:10:00"),
  ),

  // 5. DELIVERED - Fulfilled local retail shop order
  OrderModel(
    id: "6712ab129f1c4e78a23001fg345305",
    buyerId: "6708d7211a9c8f2b34a09855",
    productId: "SHG_PRD_005",
    name: "Traditional Multi-Millet Khakhra",
    imageUrl: "https://falgunifood.com/cdn/shop/files/254-Multi-MIllets-Khakhara-1080px-X-1080px-01.jpg?v=1745572349",
    quantity: 80.0,
    unit: "PACKS",
    pricePerUnit: 70.0,
    totalPrice: 5600.0,
    status: OrderStatus.DELIVERED,
    createdAt: DateTime.parse("2026-10-12T13:20:00"),
    updatedAt: DateTime.parse("2026-10-14T15:40:00"),
  ),

  // 6. CANCELLED - Cancelled by customer before confirmation
  OrderModel(
    id: "6712ab129fvb451c4e78a2300106",
    buyerId: "6708d7211a9c8f2b34a09844",
    productId: "SHG_PRD_001",
    name: "Roasted Millet Flour Mix",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpD4zTMqUOaQDVliFkQo6S5Ru-RGaaHV-weq5fVZO7v0kRkOJOvjjJtggX&s=10",
    quantity: 15.0,
    unit: "PACKS",
    pricePerUnit: 85.0,
    totalPrice: 1275.0,
    status: OrderStatus.CANCELLED,
    createdAt: DateTime.parse("2026-10-11T16:00:00"),
    updatedAt: DateTime.parse("2026-10-11T17:30:00"),
  ),
];