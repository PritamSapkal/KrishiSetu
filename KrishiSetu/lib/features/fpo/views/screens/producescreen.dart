import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishisetu/features/fpo/views/screens/AddProduceScreen.dart';
// Adjust path if needed
import '../../../../core/models/ProductModel.dart';
import '../../dummydata/ProductListingDummyData.dart';
import '../../viewmodels/ProduceListRiverpod.dart';
import 'produceDetailsScreen.dart';

class Producescreen extends ConsumerStatefulWidget {
  const Producescreen({super.key});

  static const Color primaryBrown = Color(0xff8D4F1E);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);

  @override
  ConsumerState<Producescreen> createState() => _ProducescreenState();
}

class _ProducescreenState extends ConsumerState<Producescreen> {
  @override
  Widget build(BuildContext context) {
    // Total stock quantity across all listed products
    final double totalQuantity = ref.watch(ProduceListProvider).fold(
      0.0,
          (sum, item) => sum + ((item.quantity ?? 0).toDouble()),
    );

    return Scaffold(
      backgroundColor: Producescreen.scaffoldBg,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Column(
          children: [
            // Top Summary Card
            _buildTotalInventoryCard(totalQuantity),
            SizedBox(height: 14.h),

            // Dynamic Product Cards List
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: mockProductList.length,
              separatorBuilder: (context, index) => SizedBox(height: 14.h),
              itemBuilder: (context, index) {
                final product = mockProductList[index];
                return _buildProductCard(product, context, index);
              },
            ),
            SizedBox(height: 14.h),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => Addproducescreen(),));
      },
        backgroundColor: Color(0xff964900),
        child: Center(child: Icon(Icons.add,color: Colors.white,),),),
    );
  }

  // --- Total Inventory Volume Banner ---
  Widget _buildTotalInventoryCard(double totalQuantity) {
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
                "Total Listed Inventory",
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  color: Producescreen.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "${totalQuantity.toStringAsFixed(1)} Units",
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Producescreen.primaryBrown,
                ),
              ),
            ],
          ),
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: const Color(0xffFAF0E6),
              borderRadius: BorderRadius.circular(22.r),
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              color: Producescreen.primaryBrown,
              size: 22.sp,
            ),
          ),
        ],
      ),
    );
  }

  // --- Individual Product Card ---
  Widget _buildProductCard(ProductModel product, BuildContext context, int index) {
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
                  height: 120.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 120.h,
                      width: double.infinity,
                      color: const Color(0xffFAF0E6),
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Producescreen.primaryBrown,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 120.h,
                    width: double.infinity,
                    color: const Color(0xffEAEFF5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.eco, color: Producescreen.primaryBrown, size: 36.sp),
                        SizedBox(height: 4.h),
                        Text(
                          "No Preview Image",
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            color: Producescreen.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Status Badge (Active / Inactive / Out of Stock)
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
                            : (hasStock ? "In Stock" : "Out of Stock"),
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

          // Product Information Content Section
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
                    color: Producescreen.textDark,
                  ),
                ),

                // Category
                Text(
                  "Category: ${product.category ?? 'Uncategorized'}",
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    color: Producescreen.textMuted,
                  ),
                ),
                SizedBox(height: 12.h),

                // Available Quantity & Price Per Unit Row
                Row(
                  children: [
                    // Quantity Available
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Available Stock",
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              color: Producescreen.textMuted,
                            ),
                          ),
                          Text(
                            "${product.quantity ?? 0} ${product.unit ?? ''}",
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: Producescreen.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Price per Unit
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Unit Price",
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              color: Producescreen.textMuted,
                            ),
                          ),
                          Text(
                            "₹${product.price?.toStringAsFixed(0) ?? '0'}/${product.unit ?? 'Unit'}",
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: Producescreen.primaryBrown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                // Description snippet
                Text(
                  product.description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    color: Producescreen.textMuted,
                  ),
                ),
                SizedBox(height: 14.h),

                // Action Buttons
                Row(
                  children: [
                    // View Details Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Producedetailsscreen(index: index),
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
                            color: Producescreen.primaryBrown,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),

                    // Edit / Manage Listing Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Producescreen.primaryBrown,
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
  }
}