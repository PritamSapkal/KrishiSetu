import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../dummydata/unified_marketplace_products.dart';
import '../viewmodels/cart_riverpod.dart';
import '../viewmodels/consumer_bottom_index_provider.dart';

class ProductBuyDetailsScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductBuyDetailsScreen({required this.productId, super.key});

  @override
  ConsumerState<ProductBuyDetailsScreen> createState() =>
      _ProductBuyDetailsScreenState();
}

class _ProductBuyDetailsScreenState
    extends ConsumerState<ProductBuyDetailsScreen> {
  static const Color primaryColor = Color(0xff004D40); // Deep Emerald Teal
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);
  static const Color cardSubBg = Color(0xffE0F2F1);

  int _selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    // Look up the marketplace item by productId
    final MarketplaceItem? item = unifiedMarketplaceList
        .cast<MarketplaceItem?>()
        .firstWhere((m) => m?.product.id == widget.productId, orElse: () => null);

    final currencyFormatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    if (item == null) {
      return Scaffold(
        backgroundColor: scaffoldBg,
        appBar: AppBar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          title: Text(
            "Product Not Found",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ),
        body: Center(
          child: Text(
            "Product #${widget.productId} is currently unavailable.",
            style: GoogleFonts.poppins(color: textMuted, fontSize: 13.sp),
          ),
        ),
      );
    }

    final product = item.product;
    final double unitPrice = product.price?.toDouble() ?? 0.0;
    final double totalPrice = unitPrice * _selectedQuantity;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Product Details",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(item, totalPrice),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Large Hero Product Image
            _buildHeroImage(product.imageUrl ?? '', item.sellerRole),
            SizedBox(height: 14.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Product Title & In-Stock Badge
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name ?? 'Produce Item',
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: textDark,
                            height: 1.25,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: const Color(0xffE8F5E9),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          "In Stock",
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff2E7D32),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),

                  // 3. Producer Credential Card
                  _buildProducerCard(item),
                  SizedBox(height: 14.h),

                  // 4. Price & Stepper Selector Card
                  _buildPriceAndStepperCard(unitPrice, product.unit ?? 'Unit'),
                  SizedBox(height: 14.h),

                  // 5. Product Specifications Table
                  _buildSpecsCard(product, item.sellerRole),
                  SizedBox(height: 14.h),

                  // 6. Detailed Description
                  _buildDescriptionCard(product.description),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Hero Image Widget ---
  Widget _buildHeroImage(String imageUrl, String sellerRole) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          width: double.infinity,
          height: 220.h,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 220.h,
              color: cardSubBg,
              child: const Center(
                child: CircularProgressIndicator(color: primaryColor),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            height: 220.h,
            color: const Color(0xffECEFEF),
            child: Icon(Icons.eco_outlined, color: primaryColor, size: 48.sp),
          ),
        ),
        Positioned(
          bottom: 12.h,
          left: 14.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              "Direct from $sellerRole",
              style: GoogleFonts.poppins(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- Producer Identity Card ---
  Widget _buildProducerCard(MarketplaceItem item) {
    Color badgeColor;
    switch (item.sellerRole.toLowerCase()) {
      case 'farmer':
        badgeColor = const Color(0xff2E7D32);
        break;
      case 'fpo':
        badgeColor = const Color(0xff964900);
        break;
      case 'shg':
        badgeColor = const Color(0xff880D4F);
        break;
      case 'processor':
        badgeColor = const Color(0xff4A148C);
        break;
      default:
        badgeColor = primaryColor;
    }

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: badgeColor.withOpacity(0.12),
            child: Icon(Icons.verified_outlined, color: badgeColor, size: 20.sp),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.sellerName,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                Text(
                  "Verified ${item.sellerRole} Producer Cluster",
                  style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Price & Quantity Stepper Card ---
  Widget _buildPriceAndStepperCard(double unitPrice, String unit) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 0.5)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Rate
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Price",
                style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "₹${unitPrice.toStringAsFixed(0)}",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    " / $unit",
                    style: GoogleFonts.poppins(fontSize: 11.sp, color: textMuted),
                  ),
                ],
              ),
            ],
          ),

          // Stepper (+ / -)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: cardSubBg,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: primaryColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: 16),
                  color: primaryColor,
                  onPressed: () {
                    if (_selectedQuantity > 1) {
                      setState(() => _selectedQuantity--);
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Text(
                    "$_selectedQuantity",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 16),
                  color: primaryColor,
                  onPressed: () {
                    setState(() => _selectedQuantity++);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Specifications Card ---
  Widget _buildSpecsCard(dynamic product, String sellerRole) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 0.5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "SPECIFICATIONS",
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: textMuted,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 10.h),
          _buildInfoRow("Category", product.category ?? 'Agricultural Produce'),
          const Divider(height: 16, thickness: 0.6),
          _buildInfoRow("Packaging Unit", product.unit ?? 'Unit'),
          const Divider(height: 16, thickness: 0.6),
          _buildInfoRow("Sourced Directly From", sellerRole),
          const Divider(height: 16, thickness: 0.6),
          _buildInfoRow("Quality Grade", "Standard Harvest / Cleaned"),
        ],
      ),
    );
  }

  // --- Description Card ---
  Widget _buildDescriptionCard(String? description) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 0.5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About This Produce",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            description ??
                "Fresh, organic certified millet produce directly from local farming clusters without middleman adulteration.",
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              color: textMuted,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  // --- Bottom Floating Action Bar ---
  Widget _buildBottomActionBar(MarketplaceItem item, double totalPrice) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))
        ],
      ),
      child: Row(
        children: [
          // Total for selected quantity
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Amount",
                style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
              ),
              Text(
                "₹${totalPrice.toStringAsFixed(0)}",
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(width: 14.w),

          // Add to Cart Button
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                for (int i = 0; i < _selectedQuantity; i++) {
                  ref
                      .read(cartProvider.notifier)
                      .addToCart(item.product, item.sellerRole);
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Added $_selectedQuantity item(s) to Cart!",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    backgroundColor: primaryColor,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: primaryColor, width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text(
                "Add to Cart",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),

          // Buy Now Button
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Add to cart
                for (int i = 0; i < _selectedQuantity; i++) {
                  ref
                      .read(cartProvider.notifier)
                      .addToCart(item.product, item.sellerRole);
                }

                // Close product details and jump straight to Cart tab (index 1)
                Navigator.pop(context);
                ref.read(consumerBottomIndexProvider.notifier).update((state) => 1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text(
                "Buy Now",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 11.sp, color: textMuted)),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
      ],
    );
  }
}