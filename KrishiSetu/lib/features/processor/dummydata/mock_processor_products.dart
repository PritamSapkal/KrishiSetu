import '../../../core/models/ProductModel.dart';

final List<ProductModel> mockProcessorProductList = [
  // 1. Bulk Commercial Ragi Flour
  ProductModel(
    id: "PRC_PRD_001",
    name: "Industrial Fine Ragi Flour",
    category: "Flour",
    description: "Multi-stage roller-milled, ultra-fine finger millet flour packaged in 50kg moisture-lock bulk bags for bakery and food processors.",
    imageUrl: "https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=500&q=80",
    price: 3600.0,
    quantity: 120.0,
    unit: "QUINTAL",
    sellerId: "6abe0966b9e86f93f1989df3",
    active: true,
    createdAt: "2026-10-18T09:30:00",
    updatedAt: "2026-10-19T14:10:00",
  ),

  // 2. Machine Dehulled Foxtail Millet Grains
  ProductModel(
    id: "PRC_PRD_002",
    name: "Dehulled Foxtail Millet (Kangni)",
    category: "Dehulled Grains",
    description: "Mechanically dehulled, destoned, optical-sorted unpolished foxtail grains ready for retail packaging or porridge production.",
    imageUrl: "https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80",
    price: 5800.0,
    quantity: 85.0,
    unit: "QUINTAL",
    sellerId: "6abe0966b9e86f93f1989df3",
    active: true,
    createdAt: "2026-10-17T11:00:00",
    updatedAt: "2026-10-18T16:20:00",
  ),

  // 3. Sorghum (Jowar) Coarse Rava / Semolina
  ProductModel(
    id: "PRC_PRD_003",
    name: "Processed Jowar Rava (Semolina)",
    category: "Processed",
    description: "Gluten-free coarse sorghum semolina produced through dry milling and size classification.",
    imageUrl: "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?auto=format&fit=crop&w=500&q=80",
    price: 42.0,
    quantity: 3500.0,
    unit: "KG",
    sellerId: "6abe0966b9e86f93f1989df3",
    active: true,
    createdAt: "2026-10-16T15:20:00",
    updatedAt: "2026-10-17T10:00:00",
  ),

  // 4. Steam Flattened Bajra Flakes (Poha)
  ProductModel(
    id: "PRC_PRD_004",
    name: "Steam-Rolled Pearl Millet Flakes",
    category: "Millet Product Manufacturing",
    description: "Pre-conditioned steamed bajra flakes suitable for ready-to-eat cereal breakfast mixes and roasted snack bases.",
    imageUrl: "https://images.unsplash.com/photo-1543362906-acfc16c67564?auto=format&fit=crop&w=500&q=80",
    price: 65.0,
    quantity: 1800.0,
    unit: "KG",
    sellerId: "6abe0966b9e86f93f1989df3",
    active: true,
    createdAt: "2026-10-15T08:45:00",
    updatedAt: "2026-10-16T12:30:00",
  ),

  // 5. Cleaned & Graded Little Millet Seeds
  ProductModel(
    id: "PRC_PRD_005",
    name: "Cleaned & Graded Little Millet (Kutki)",
    category: "Raw Millet",
    description: "99.5% purity double-cleaned and graded little millet seeds with dust, husk, and black grain removed by gravity separator.",
    imageUrl: "https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80",
    price: 6200.0,
    quantity: 60.0,
    unit: "QUINTAL",
    sellerId: "6abe0966b9e86f93f1989df3",
    active: true,
    createdAt: "2026-10-14T13:10:00",
    updatedAt: "2026-10-15T18:00:00",
  ),

  // 6. Bulk Wholesale Multi-Millet Atta Mix
  ProductModel(
    id: "PRC_PRD_006",
    name: "Commercial Multi-Millet Blend Atta",
    category: "Flour",
    description: "Proprietary 4-millet blended flour (Ragi, Jowar, Bajra, Kodo) formulated for commercial flatbread manufacturing.",
    imageUrl: "https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=500&q=80",
    price: 4800.0,
    quantity: 40.0,
    unit: "QUINTAL",
    sellerId: "6abe0966b9e86f93f1989df3",
    active: false, // Inactive example
    createdAt: "2026-10-12T10:00:00",
    updatedAt: "2026-10-13T11:45:00",
  ),
];