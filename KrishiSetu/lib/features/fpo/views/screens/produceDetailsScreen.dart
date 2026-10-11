import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/Widgets/Iconcart.dart';
import '../../../../core/models/ProductModel.dart';
import '../../dummydata/ProductListingDummyData.dart';

class Producedetailsscreen extends StatelessWidget {
  Producedetailsscreen({required this.index, super.key});

  final int index;
  late final ProductModel product = mockProductList[index];

  static const Color primaryBrown = Color(0xff964900);
  static const Color accentOrange = Color(0xffE07525);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);
  static const Color cardSubBg = Color(0xffFAF0E6);

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    final bool isActive = product.active ?? false;
    final bool hasStock = (product.quantity ?? 0) > 0;
    final double totalEstimatedValue =
    ((product.price ?? 0) * (product.quantity ?? 0)).toDouble();

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: primaryBrown,
        elevation: 0,
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
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image with Status Badge
            _buildHeroImage(isActive, hasStock),
            SizedBox(height: 12.h),

            // Title
            Text(
              product.name ?? 'Unnamed Product',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),

            // Category & Seller Reference
            Text(
              "Category: ${product.category ?? 'General'} • Unit: ${product.unit ?? 'N/A'}",
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: textMuted,
              ),
            ),
            SizedBox(height: 14.h),

            // Available Quantity & Average Price Cards
            Row(
              children: [
                // Total Volume Available
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.inventory_2_outlined,
                    label: "Available Stock",
                    value: "${product.quantity ?? 0} ${product.unit ?? ''}",
                  ),
                ),
                SizedBox(width: 12.w),

                // Unit Price
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.payments_outlined,
                    label: "Unit Price",
                    value:
                    "${currencyFormatter.format(product.price ?? 0)} / ${product.unit ?? 'Unit'}",
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Inventory Valuation Card
            _buildInventoryValuationCard(currencyFormatter.format(totalEstimatedValue)),
            SizedBox(height: 12.h),

            // Product Specifications Table Card
            _buildProductDetailsCard(),
            SizedBox(height: 12.h),

            // Description Card
            _buildDescriptionCard(),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  // --- Hero Banner Image ---
  Widget _buildHeroImage(bool isActive, bool hasStock) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.network(
            product.imageUrl ?? '',
            width: double.infinity,
            height: 160.h,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 160.h,
                width: double.infinity,
                color: cardSubBg,
                child: const Center(
                  child: CircularProgressIndicator(color: primaryBrown),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              height: 160.h,
              width: double.infinity,
              color: const Color(0xffECEFEF),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.eco, color: primaryBrown, size: 40.sp),
                  SizedBox(height: 6.h),
                  Text(
                    "Image not available",
                    style: GoogleFonts.poppins(fontSize: 11.sp, color: textMuted),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 10.h,
          right: 10.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  !isActive
                      ? Icons.cancel
                      : (hasStock ? Icons.check_circle : Icons.warning),
                  size: 13.sp,
                  color: !isActive
                      ? Colors.red
                      : (hasStock ? const Color(0xff2E7D32) : Colors.orange),
                ),
                SizedBox(width: 4.w),
                Text(
                  !isActive
                      ? "Inactive"
                      : (hasStock ? "Available" : "Out of Stock"),
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: !isActive
                        ? Colors.red
                        : (hasStock ? const Color(0xff2E7D32) : Colors.orange),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Metric Highlight Cards ---
  Widget _buildMetricCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Iconcart(icon: icon, iconsize: 18.sp, color: primaryBrown),
          SizedBox(height: 10.h),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              color: textMuted,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
        ],
      ),
    );
  }

  // --- Total Inventory Valuation Row ---
  Widget _buildInventoryValuationCard(String formattedTotal) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: accentOrange,
            child: const Icon(Icons.account_balance_wallet_outlined,
                color: Colors.white, size: 18),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedTotal,
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                Text(
                  "Estimated Total Stock Valuation",
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    color: textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Product Specifications Table ---
  Widget _buildProductDetailsCard() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "PRODUCT DETAILS",
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: textMuted,
            ),
          ),
          SizedBox(height: 10.h),
          _buildDetailRow("Product ID", product.id ?? 'N/A'),
          const Divider(height: 18, thickness: 0.6),
          _buildDetailRow("Category", product.category ?? 'N/A'),
          const Divider(height: 18, thickness: 0.6),
          _buildDetailRow("Unit Type", product.unit ?? 'N/A'),
          const Divider(height: 18, thickness: 0.6),
          _buildDetailRow("Seller ID", product.sellerId ?? 'N/A'),
          const Divider(height: 18, thickness: 0.6),
          _buildDetailRow(
            "Listed Date",
            product.createdAt != null
                ? product.createdAt!.split("T").first
                : "Recent",
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 11.sp, color: textMuted),
        ),
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

  // --- Product Description Card ---
  Widget _buildDescriptionCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.notes_rounded, size: 16.sp, color: textDark),
              SizedBox(width: 6.w),
              Text(
                "Description",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            product.description ?? "No description provided for this product.",
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              color: textMuted,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}