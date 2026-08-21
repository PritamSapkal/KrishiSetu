import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishisetu/ROLES/FPO/screens/produceDetailsScreen.dart';
import '../../../Data/FPO_Dummy_Data/produce_dummy_data.dart';
import '../../../Model/FarmerModel/produce_model.dart';
import '../../../Widgets/Iconcart.dart';


class Producescreen extends StatelessWidget {
  const Producescreen({super.key});

  static const Color primaryBrown = Color(0xff8D4F1E);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);

  @override
  Widget build(BuildContext context) {
    // Calculate total inventory volume dynamically
    final double totalInventory = produceslist.fold(0.0, (sum, item) => sum + item.volume,);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Column(
          children: [
            // Top Summary Card
            _buildTotalInventoryCard(totalInventory),
            SizedBox(height: 14.h),

            // Dynamic Produce Cards List
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: produceslist.length,
              separatorBuilder: (context, index) => SizedBox(height: 14.h),
              itemBuilder: (context, index) {
                final produce = produceslist[index];
                return _buildProduceCard(produce, context,index);
              },
            ),
            SizedBox(height: 14.h),
          ],
        ),
      ),
    );
  }

  // --- Total Inventory Volume Banner ---
  Widget _buildTotalInventoryCard(double totalVolume) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
          boxShadow: [BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          )]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Total inventory volume.
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // text Total Inventory Volume
              Text(
                "Total Inventory Volume",
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  color: textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              // Total Inventory volume in  number
              Text(
                "${totalVolume.toStringAsFixed(1)} Tons",
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: primaryBrown,
                ),
              ),
            ],
          ),

          //icon
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: const Color(0xffFAF0E6),
              borderRadius: BorderRadius.circular(22.r),
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              color: primaryBrown,
              size: 22.sp,
            ),
          ),
        ],
      ),
    );
  }

  // --- Individual Produce Card ---
  Widget _buildProduceCard(ProduceModel produce, dynamic context,int index) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
          boxShadow: [BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          )]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with In Stock Badge
          Stack(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: Image.asset(
                  produce.image,
                  height: 120.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 120.h,
                    width: double.infinity,
                    color: const Color(0xffEAEFF5),
                    child: Icon(Icons.eco, color: primaryBrown, size: 36.sp),
                  ),
                ),
              ),

              // In Stock Container
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 3.r,
                        backgroundColor: const Color(0xff2E7D32),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        produce.status == "Available" ? "In Stock" : produce.status,
                        style: GoogleFonts.poppins(
                          fontSize: 9.sp,
                          color: const Color(0xff2E7D32),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Produce Information Content section
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Crop Title
                Text(
                  produce.name,
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),

                // Produce Grade & Variety
                Text(
                  "${produce.grade} (Variety: ${produce.details.variety})",
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    color: textMuted,
                  ),
                ),
                SizedBox(height: 12.h),

                // Volume & Contributors Row
                Row(
                  children: [
                    // Volume
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Volume Text
                          Text(
                            "Volume",
                            style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                          ),
                          // Volume Number
                          Text(
                            "${produce.volume} T",
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: textDark,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Contributors
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contributors",
                            style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                          ),
                          Text(
                            "${produce.contributingFarmers} Farmers",
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                // Produce Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Price",
                      style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                    ),
                    Text(
                      "₹${produce.details.averagePrice.toInt()}/${produce.details.priceUnit.replaceAll('per ', '')}",
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: textDark,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),

                // Produce Location
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Location",
                      style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                    ),
                    Text(
                      produce.details.storageLocation,
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: textDark,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),

                // Action Buttons
                Row(
                  children: [

                    // View Details Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => Producedetailsscreen(index:index),));
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
                            color: primaryBrown,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),

                    // Create Listing Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBrown,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                        ),
                        child: Text(
                          "Create Listing",
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