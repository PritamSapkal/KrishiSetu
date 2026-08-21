import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../Data/FPO_Dummy_Data/produce_dummy_data.dart';
import '../../../Model/FarmerModel/produce_model.dart';
import '../../../Widgets/Iconcart.dart';

class Producedetailsscreen extends StatelessWidget {
  Producedetailsscreen({required this.index, super.key});

  final int index;
  late final ProduceModel produce = produceslist[index];

  static const Color primaryBrown = Color(0xff964900);
  static const Color accentOrange = Color(0xffE07525);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);
  static const Color cardSubBg = Color(0xffFAF0E6);

  @override
  Widget build(BuildContext context) {
    // currency formater
    final currencyFormatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    // available storage space ratio
    final double usageRatio = produce.volume / produce.details.storageCapacity;
    final int usagePercent = (usageRatio * 100).toInt();

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
            // Top Image with Status Badge
            _buildHeroImage(),
            SizedBox(height: 12.h),

            // Title
            Text(
              produce.name,
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),

            // Grade & Variety
            Text(
              "${produce.grade} • ${produce.details.variety}",
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: textMuted,
              ),
            ),
            SizedBox(height: 14.h),

            // Volume & Average Price Cards
            Row(
              children: [
                // Total Volume
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.hourglass_bottom_outlined,
                    label: "Total Volume",
                    value: "${produce.volume} ${produce.volumeUnit[0].toUpperCase()}${produce.volumeUnit.substring(1)}",
                  ),
                ),

                SizedBox(width: 12.w),

                // Average Price
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.payments_outlined,
                    label: "Average Price",
                    value: "${currencyFormatter.format(produce.details.averagePrice)} / qtl",
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Farmers Contributing Card
            _buildContributingFarmersCard(),
            SizedBox(height: 12.h),

            // Lot Details Table Card
            _buildLotDetailsCard(),
            SizedBox(height: 12.h),

            // Storage Location & Capacity Card
            _buildStorageLocationCard(usageRatio, usagePercent),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  // --- Hero Banner Image ---
  Widget _buildHeroImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.asset(
            produce.image,
            width: double.infinity,
            height: 150.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 150.h,
              width: double.infinity,
              color: const Color(0xffECEFEF),
              child: const Icon(Icons.eco, color: primaryBrown, size: 40),
            ),
          ),
        ),
        Positioned(
          top: 10.h,
          right: 10.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, size: 12, color: Color(0xff2E7D32)),
                SizedBox(width: 4.w),
                Text(
                  produce.status,
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff2E7D32),
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
          boxShadow: [BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          )]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Iconcart(icon: icon, iconsize: 18.sp, color:primaryBrown,),
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

  // --- Farmers Contributing Row ---
  Widget _buildContributingFarmersCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
          boxShadow: [BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          )]
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: accentOrange,
            child: const Icon(Icons.group_outlined, color: Colors.white, size: 18),
          ),
          SizedBox(width: 10.w),

          // farmer Count & Contributing to this Slot Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // farmer count
                Text(
                  "${produce.contributingFarmers} Farmers",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                // Contributing to this slot text
                Text(
                  "Contributing to this lot",
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    color: textMuted,
                  ),
                ),
              ],
            ),
          ),
          // View Text Button
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              "View",
              style: GoogleFonts.poppins(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: primaryBrown,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Lot Details Table ---
  Widget _buildLotDetailsCard() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
          boxShadow: [BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          )]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "LOT DETAILS",
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: textMuted,
            ),
          ),
          SizedBox(height: 10.h),
          _buildDetailRow("Variety", produce.details.variety),
          const Divider(height: 18, thickness: 0.6),
          _buildDetailRow("Harvest Season", produce.details.harvestSeason),
          const Divider(height: 18, thickness: 0.6),
          _buildDetailRow("Grade", produce.grade),
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

  // --- Storage Location Card ---
  Widget _buildStorageLocationCard(double usageRatio, int usagePercent) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
          boxShadow: [BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          )]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Storage Location icon & Text
          Row(
            children: [
              Icon(Icons.warehouse_outlined, size: 16.sp, color: textDark),
              SizedBox(width: 6.w),
              Text(
                "Storage Location",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // Storage Location Name
          Text(
            produce.details.storageLocation,
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              color: textMuted,
            ),
          ),
          SizedBox(height: 12.h),

          // Capacity usage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Capacity Usage",
                style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
              ),
              Text(
                "${produce.volume.toInt()} / ${produce.details.storageCapacity.toInt()} ${produce.details.storageUnit}",
                style: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // Linear Progress indicator
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: usageRatio.clamp(0.0, 1.0),
              backgroundColor: const Color(0xffECEFEF),
              valueColor: const AlwaysStoppedAnimation<Color>(primaryBrown),
              minHeight: 6.h,
            ),
          ),
          SizedBox(height: 6.h),

          // Percentage
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "$usagePercent% Full",
              style: GoogleFonts.poppins(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}