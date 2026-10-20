import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/ProductModel.dart';
import '../viewmodels/ProcessorProductListRiverpod.dart';
import 'ProcessorAddProductScreen.dart';
import 'ProcessorProductDetailScreen.dart'; // Adjust path to ProcessorproductlistProvider

class ProcessorProductScreen extends ConsumerWidget {
  const ProcessorProductScreen({super.key});

  static const Color primaryColor = Color(0xff4A148C);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);
  static const Color cardSubBg = Color(0xffF3E5F5);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching the Riverpod product list state
    final List<ProductModel> products = ref.watch(ProcessorproductlistProvider);

    // Dynamic stock volume calculation
    final double totalStockVolume = products.fold(
      0.0,
          (sum, item) => sum + (item.quantity ?? 0.0),
    );

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Column(
          children: [
            // Top Summary Card
            _buildTotalInventoryCard(totalStockVolume, products.length),
            SizedBox(height: 14.h),

            // Processed Goods List
            products.isEmpty
                ? Padding(
              padding: EdgeInsets.only(top: 60.h),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 48.sp,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "No processed goods listed yet",
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            )
                : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: products.length,
              separatorBuilder: (context, index) => SizedBox(height: 14.h),
              itemBuilder: (context, index) {
                final product = products[index];
                return _buildProductCard(product, context);
              },
            ),
            SizedBox(height: 14.h),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder:(context)=>ProcessorAddProductScreen()));
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // --- Total Inventory Banner ---
  Widget _buildTotalInventoryCard(double totalVolume, int totalSkus) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Processed Output Stock",
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  color: textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "${totalVolume.toStringAsFixed(1)} Units",
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: cardSubBg,
              borderRadius: BorderRadius.circular(22.r),
            ),
            child: Icon(
              Icons.precision_manufacturing_outlined,
              color: primaryColor,
              size: 22.sp,
            ),
          ),
        ],
      ),
    );
  }

  // --- Individual Product Card ---
  Widget _buildProductCard(ProductModel product, BuildContext context) {
    final bool isActive = product.active ?? false;
    final bool hasStock = (product.quantity ?? 0) > 0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
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
          // Network Image with Status Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: Image.network(
                  product.imageUrl ?? '',
                  height: 125.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 125.h,
                      width: double.infinity,
                      color: cardSubBg,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: primaryColor,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 125.h,
                    width: double.infinity,
                    color: const Color(0xffECEFEF),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.factory_outlined, color: primaryColor, size: 36.sp),
                        SizedBox(height: 4.h),
                        Text(
                          "No Preview Image",
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            color: textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Active / Stock Status Badge
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 3.r,
                        backgroundColor: !isActive
                            ? Colors.red
                            : (hasStock ? const Color(0xff2E7D32) : Colors.orange),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        !isActive
                            ? "Inactive"
                            : (hasStock ? "Available" : "Out of Stock"),
                        style: GoogleFonts.poppins(
                          fontSize: 9.sp,
                          color: !isActive
                              ? Colors.red
                              : (hasStock ? const Color(0xff2E7D32) : Colors.orange),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Content Information Section
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  product.name ?? 'Unnamed Product',
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),

                // Category
                Text(
                  "Activity Category: ${product.category ?? 'Milled'}",
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    color: textMuted,
                  ),
                ),
                SizedBox(height: 12.h),

                // Available Stock & Wholesale Price Row
                Row(
                  children: [
                    // Stock Quantity
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Available Inventory",
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              color: textMuted,
                            ),
                          ),
                          Text(
                            "${product.quantity ?? 0} ${product.unit ?? ''}",
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: textDark,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Unit Price
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Wholesale Rate",
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              color: textMuted,
                            ),
                          ),
                          Text(
                            "₹${product.price?.toStringAsFixed(0) ?? '0'}/${product.unit ?? 'Unit'}",
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                // Description
                Text(
                  product.description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    color: textMuted,
                  ),
                ),
                SizedBox(height: 14.h),

                // Action Buttons
                Row(
                  children: [
                    // View Details Button (Passing productId directly)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProcessorProductDetailScreen(
                                productId: product.id ?? '', // Passing product ID
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                        ),
                        child: Text(
                          "View Details",
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),

                    // Manage Stock Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                        ),
                        child: Text(
                          "Manage Stock",
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }}
