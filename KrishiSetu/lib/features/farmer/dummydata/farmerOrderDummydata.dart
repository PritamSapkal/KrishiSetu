import '../../../core/models/OrderModel.dart';

final List<OrderModel> mockFarmerOrderList = [
  // 1. PENDING - Fresh harvest order placed by a local FPO/Buyer
  OrderModel(
    id: "6718ef129f1c4ea78a2wer43300301",
    buyerId: "6708d7211a9c8f2b34a09899",
    productId: "FAR_PRD_001",
    name: "Raw Maldandi Jowar (Sorghum)",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdyBlxAMl56s6vW6Ldwmu7bT-9f2hI9iE_VPfH4NJBag&s=10",
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
    id: "6718ef129fs1c4e7hj678a2300302",
    buyerId: "6708d7211a9c8f2b34a09877",
    productId: "FAR_PRD_002",
    name: "Farm Fresh Ragi (Finger Millet)",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe0zMjS05_diRWunyxLrsNpshWgcXoPkXPdA9lADhehA&s",
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
    id: "6718ef1h3429fd1c4e78a2300303",
    buyerId: "6708d7211a9c8f2b34a09888",
    productId: "FAR_PRD_003",
    name: "Organic Pearl Millet (Bajra)",
    imageUrl: "https://milletamma.com/cdn/shop/files/Pearl-Millet_1_900x.webp?v=1778655594",
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
    id: "6718ef12jk459ff1c4e78a2300304",
    buyerId: "6708d7211a9c8f2b34a09866",
    productId: "FAR_PRD_004",
    name: "Unpolished Foxtail Millet (Kangni)",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHyTw1PdrlHzjiRNt1KQ43zygCsghEHzZIeVCE2x51jA&s=10",
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
    id: "6718ef12jdfg476g9f1c4e78a2300305",
    buyerId: "6708d7211a9c8f2b34a09855",
    productId: "FAR_PRD_005",
    name: "Golden Little Millet (Kutki)",
    imageUrl: "https://5.imimg.com/data5/ANDROID/Default/2026/2/582007435/TX/QV/FF/229339848/product-jpeg-500x500.jpg",
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
    id: "6718ef1283hdbf9f1c4e78a2300306",
    buyerId: "6708d7211a9c8f2b34a09844",
    productId: "FAR_PRD_001",
    name: "Raw Maldandi Jowar (Sorghum)",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyX2wyn3TgjFvjfqNIaJfJnka7zaFGsKJZQ12PD-EXRxO7bqxX7mnDuQMa&s=10",
    quantity: 5.0,
    unit: "QUINTAL",
    pricePerUnit: 3400.0,
    totalPrice: 17000.0,
    status: OrderStatus.CANCELLED,
    createdAt: DateTime.parse("2026-10-14T13:10:00"),
    updatedAt: DateTime.parse("2026-10-14T14:00:00"),
  ),
];