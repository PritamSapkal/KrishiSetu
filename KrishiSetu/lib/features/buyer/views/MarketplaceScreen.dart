import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dummydata/unified_marketplace_products.dart';
import '../viewmodels/cart_riverpod.dart';
import '../viewmodels/marketplace_riverpod.dart';
import 'ProductBuyDetailsScreen.dart';

class MarketplaceScreen extends ConsumerStatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  ConsumerState<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends ConsumerState<MarketplaceScreen> {
  static const Color primaryColor = Color(0xff004D40); // Deep Emerald Teal
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);

  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    "All",
    "Raw Millet",
    "Flour",
    "Dehulled Grains",
    "Spices",
    "Edible Oils",
    "Pickles & Preserves",
    "Handicrafts",
    "Processed",
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch filtered marketplace items from Riverpod
    final List<MarketplaceItem> marketplaceItems = ref.watch(filteredMarketplaceProvider);
    final String activeCategory = ref.watch(selectedMarketCategoryProvider);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: Column(
        children: [
          // 1. Search Bar
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 10.h),
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                ref.read(marketplaceSearchQueryProvider.notifier).state = val;
              },
              style: GoogleFonts.poppins(color: textDark, fontSize: 13.sp),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                prefixIcon: Icon(Icons.search_rounded, color: primaryColor, size: 20.sp),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    ref.read(marketplaceSearchQueryProvider.notifier).state = "";
                  },
                )
                    : null,
                hintText: "Search millets, flours, oils, snacks...",
                hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 12.sp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: primaryColor, width: 1.4),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
              ),
            ),
          ),

          // 2. Horizontal Scrolling Category Pills
          SizedBox(
            height: 38.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (context, index) => SizedBox(width: 8.w),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = activeCategory.toLowerCase() == category.toLowerCase();

                return GestureDetector(
                  onTap: () {
                    ref.read(selectedMarketCategoryProvider.notifier).state = category;
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.grey.shade300,
                        width: 1,
                      ),
                      boxShadow: isSelected
                          ? [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        )
                      ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: GoogleFonts.poppins(
                          fontSize: 11.sp,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? Colors.white : const Color(0xff595F6B),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.h),

          // 3. 2-Column Product Grid
          Expanded(
            child: marketplaceItems.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off_rounded, size: 48.sp, color: Colors.grey.shade400),
                  SizedBox(height: 10.h),
                  Text(
                    "No products found",
                    style: GoogleFonts.poppins(fontSize: 14.sp, color: textMuted),
                  ),
                ],
              ),
            )
                : GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 16.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 0.68, // Balanced aspect ratio for image, title, badge & price
              ),
              itemCount: marketplaceItems.length,
              itemBuilder: (context, index) {
                final item = marketplaceItems[index];
                return _buildMarketProductCard(item, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- Product Card Component ---
  Widget _buildMarketProductCard(MarketplaceItem item, BuildContext context) {
    final product = item.product;

    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductBuyDetailsScreen(
              productId: product.id ?? '',
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 0.5,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack with Seller Tag Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
                  child: Image.network(
                    product.imageUrl ?? '',
                    height: 120.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 120.h,
                        color: const Color(0xffE0F2F1),
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: primaryColor,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 120.h,
                      color: const Color(0xffECEFEF),
                      child: Icon(Icons.eco_outlined, color: primaryColor, size: 30.sp),
                    ),
                  ),
                ),

                // Seller Origin Badge
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: _buildSellerBadge(item.sellerRole),
                ),
              ],
            ),

            // Card Body
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name ?? 'Produce Item',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: textDark,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          item.sellerName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 9.sp,
                            color: textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    // Price & Direct Add to Cart (+) Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "₹${product.price?.toStringAsFixed(0) ?? '0'}",
                                style: GoogleFonts.poppins(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "per ${product.unit ?? 'Unit'}",
                                style: GoogleFonts.poppins(
                                  fontSize: 9.sp,
                                  color: textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Mini Add (+) Cart Button
                        InkWell(
                          onTap: () {
                            ref
                                .read(cartProvider.notifier)
                                .addToCart(product, item.sellerRole);

                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Added to cart",
                                  style: GoogleFonts.poppins(color: Colors.white),
                                ),
                                duration: const Duration(seconds: 1),
                                backgroundColor: primaryColor,
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(8.r),
                          child: Container(
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Seller Tag Helper ---
  Widget _buildSellerBadge(String role) {
    Color bg;
    Color fg;

    switch (role.toLowerCase()) {
      case 'farmer':
        bg = const Color(0xffE8F5E9);
        fg = const Color(0xff2E7D32);
        break;
      case 'fpo':
        bg = const Color(0xffFAF0E6);
        fg = const Color(0xff964900);
        break;
      case 'shg':
        bg = const Color(0xffFCE4EC);
        fg = const Color(0xff880D4F);
        break;
      case 'processor':
        bg = const Color(0xffF3E5F5);
        fg = const Color(0xff4A148C);
        break;
      default:
        bg = const Color(0xffE0F2F1);
        fg = primaryColor;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: fg.withOpacity(0.4), width: 0.8),
      ),
      child: Text(
        role.toUpperCase(),
        style: GoogleFonts.poppins(
          fontSize: 8.sp,
          fontWeight: FontWeight.bold,
          color: fg,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
