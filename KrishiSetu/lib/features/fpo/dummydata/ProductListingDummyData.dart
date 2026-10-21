import '../../../core/models/ProductModel.dart';

final List<ProductModel> mockProductList = [
  // 1. Organic Finger Millet (Ragi)
  ProductModel(
    id: "6708db4jh7e21a923fg76c8f2b34a10001",
    name: "Organic Finger Millet (Ragi)",
    category: "Raw Millet",
    description: "High-calcium, sun-dried organic ragi grains collected directly from local member farmers.",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnPzcl0Frh4koInEpq2Bag_DxcqkeXIbXCOXTlw2BCWA&s=10",
    price: 45.0,
    quantity: 1200.0,
    unit: "KG",
    sellerId: "6708d7211a9c8f2b34a09876",
    active: true,
    createdAt: "2026-10-11T10:30:00",
    updatedAt: "2026-10-11T12:00:00",
  ),

  // 2. Pearl Millet (Bajra)
  ProductModel(
    id: "6708db421a9c8f2fgh6b34a1hdfg640002",
    name: "Pearl Millet (Bajra)",
    category: "Raw Millet",
    description: "Premium quality cleaned bajra suitable for flour milling and wholesale poultry/cattle feed.",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUch-AEgZRSqrUzjbfzWp0EnFlMYFvNUMbyhGJ0D_z1eZomfFsetbXHlk&s=10",
    price: 38.0,
    quantity: 850.0,
    unit: "KG",
    sellerId: "6708d7211a9c8f2b34a09876",
    active: true,
    createdAt: "2026-10-10T09:00:00",
    updatedAt: "2026-10-10T14:30:00",
  ),

  // 3. Foxtail Millet (Kangni)
  ProductModel(
    id: "670dsfhg58db421a9c8fas98u2b34a10003",
    name: "Foxtail Millet (Kangni)",
    category: "Raw Millet",
    description: "Unpolished, nutrient-dense whole grain foxtail millets with low glycemic index.",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSj7TsQLmqz8dcLUeWXRbo0cXRU5r84z-ohJgb9Bc7zfbOvYoS79Te6oJKs&s=10",
    price: 65.0,
    quantity: 400.0,
    unit: "KG",
    sellerId: "6708d7211a9c8f2b34a09876",
    active: true,
    createdAt: "2026-10-09T11:20:00",
    updatedAt: "2026-10-09T11:20:00",
  ),

  // 4. Roasted Multi-Millet Flour
  ProductModel(
    id: "6708db421a9cbfh3478b5xd8f2b34a10004",
    name: "Roasted Multi-Millet Flour",
    category: "Flour",
    description: "Traditional stone-ground flour mix made of Ragi, Jowar, and Bajra. Ready to cook.",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzQ_8j6NE79RAj_Z5FpkGAN-7l96-SbFSbCaY7tpE3UVb3jwsPJPeFJxo&s=10",
    price: 80.0,
    quantity: 150.0,
    unit: "PACKS",
    sellerId: "6708d7211a9c8f2b34a09876",
    active: true,
    createdAt: "2026-10-08T15:45:00",
    updatedAt: "2026-10-09T08:15:00",
  ),

  // 5. White Sorghum (Jowar) - Bulk Quintal Listing
  ProductModel(
    id: "6708djgh56b42kl81a9c8f2b34a10005",
    name: "Maldandi Sorghum (Jowar)",
    category: "Raw Millet",
    description: "High-grade Maldandi jowar grains packed in sturdy bulk bags for processors and traders.",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpB-swBijp1Mj9nDG9pkOW9WKBBhf1s_-AuXbVM_jepw&s=10",
    price: 4200.0,
    quantity: 25.0,
    unit: "QUINTAL",
    sellerId: "6708d7211a9c8f2b34a09876",
    active: true,
    createdAt: "2026-10-07T12:00:00",
    updatedAt: "2026-10-07T12:00:00",
  ),

  // 6. Inactive / Out of Stock Product (for testing inactive state toggles)
  ProductModel(
    id: "6708as12db421as98ja9c8f2b34a10006",
    name: "Proso Millet (Variga)",
    category: "Raw Millet",
    description: "Farm-harvested proso millet batch, temporarily disabled pending harvest batch verification.",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTakoELGqVkte7HDqvms4fUTsOHgHITUlyE51id_SnPfw&s=10",
    price: 55.0,
    quantity: 0.0,
    unit: "KG",
    sellerId: "6708d7211a9c8f2b34a09876",
    active: false,
    createdAt: "2026-10-05T09:10:00",
    updatedAt: "2026-10-06T16:00:00",
  ),
];