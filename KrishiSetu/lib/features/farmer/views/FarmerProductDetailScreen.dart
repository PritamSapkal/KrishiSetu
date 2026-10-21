import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/Widgets/Iconcart.dart';
import '../../../core/models/ProductModel.dart';
import '../viewmodels/FarmerProductListRiverpod.dart';

class Farmerproductdetailscreen extends ConsumerWidget {
  const Farmerproductdetailscreen({required this.productid, super.key});
  final String productid;

  static const Color primaryColor = Color(0xff2E7D32);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);
  static const Color cardSubBg = Color(0xffE8F5E9);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the live list of products from Riverpod
    final List<ProductModel> products = ref.watch(FarmerProductListProvider);

    // Find the product by productid
    final ProductModel? product = products.cast<ProductModel?>().firstWhere(
          (p) => p?.id == productid,
      orElse: () => null,
    );

    final currencyFormatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    if (product == null) {
      return Scaffold(
        backgroundColor: scaffoldBg,
        appBar: AppBar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          title: Text(
            "Produce Not Found",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ),
        body: Center(
          child: Text(
            "Produce #$productid could not be found.",
            style: GoogleFonts.poppins(color: textMuted, fontSize: 13.sp),
          ),
        ),
      );
    }

    final bool isActive = product.active ?? false;
    final bool hasStock = (product.quantity ?? 0) > 0;
    final double totalHarvestValue =
    ((product.price ?? 0) * (product.quantity ?? 0)).toDouble();

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
          "Produce Details",
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
            // 1. Hero Image with Stock Badge
            _buildHeroImage(product, isActive, hasStock),
            SizedBox(height: 12.h),

            // 2. Crop Title
            Text(
              product.name ?? 'Unnamed Produce',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),

            // 3. Category & Unit Subtitle
            Text(
              "Category: ${product.category ?? 'Raw Millet'} • Selling Unit: ${product.unit ?? 'N/A'}",
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: textMuted,
              ),
            ),
            SizedBox(height: 14.h),

            // 4. Metric Cards (Available Quantity & Farm Price)
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.grain_outlined,
                    label: "Available Quantity",
                    value: "${product.quantity ?? 0} ${product.unit ?? ''}",
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.payments_outlined,
                    label: "Farm-Gate Rate",
                    value:
                    "${currencyFormatter.format(product.price ?? 0)} / ${product.unit ?? 'Unit'}",
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // 5. Total Harvest Valuation Banner
            _buildValuationCard(currencyFormatter.format(totalHarvestValue)),
            SizedBox(height: 12.h),

            // 6. Crop Lot Specifications Card
            _buildSpecificationsCard(product),
            SizedBox(height: 12.h),

            // 7. Crop Harvest & Quality Description Card
            _buildDescriptionCard(product.description),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // --- 1. Hero Image Widget ---
  Widget _buildHeroImage(ProductModel product, bool isActive, bool hasStock) {
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
                  child: CircularProgressIndicator(color: primaryColor),
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
                  Icon(Icons.eco_outlined, color: primaryColor, size: 40.sp),
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

  // --- 2. Metric Highlight Card ---
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
            blurRadius: 4,
            spreadRadius: 0.5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Iconcart(icon: icon, iconsize: 18.sp, color: primaryColor),
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

  // --- 3. Harvest Lot Valuation Card ---
  Widget _buildValuationCard(String formattedTotal) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 0.5,
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: primaryColor.withOpacity(0.12),
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              color: primaryColor,
              size: 18,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedTotal,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                Text(
                  "Estimated Harvest Lot Value",
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

  // --- 4. Crop Lot Specifications Card ---
  Widget _buildSpecificationsCard(ProductModel product) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 0.5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "CROP SPECIFICATIONS",
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: textMuted,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 10.h),
          _buildDetailRow("Lot SKU ID", "#${product.id ?? 'N/A'}"),
          const Divider(height: 16, thickness: 0.6),
          _buildDetailRow("Crop Category", product.category ?? 'Raw Millet'),
          const Divider(height: 16, thickness: 0.6),
          _buildDetailRow("Quantity Unit", product.unit ?? 'N/A'),
          const Divider(height: 16, thickness: 0.6),
          _buildDetailRow("Farmer Seller ID", "#${product.sellerId ?? 'N/A'}"),
          const Divider(height: 16, thickness: 0.6),
          _buildDetailRow(
            "Harvest Listed Date",
            product.createdAt != null ? product.createdAt!.split("T").first : "Recent",
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
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

  // --- 5. Crop Description Card ---
  Widget _buildDescriptionCard(String? description) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 0.5,
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
                "Farm Harvest Notes",
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
            description ?? "No detailed harvest notes provided for this produce.",
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