import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dummydata/ShgMember_DummyData.dart';
import '../models/ShgMemberModel.dart';
import '../viewmodels/MemberListRiverpod.dart'; // Adjust path if needed

class SHGMemberDetailsPage extends ConsumerWidget {
  final int index;
  const SHGMemberDetailsPage({required this.index, super.key});

  static const Color primaryColor = Color(0xff880D4F);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff585F6C);
  static const Color cardSubBg = Color(0xffFAF0E6);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final ShgMemberModel member = ref.watch(MemberlistProvider)[index];

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          "Member Profile",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            // 1. Top Header Profile Banner
            _buildHeroHeader(member),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              child: Column(
                children: [

                  // 3. Member ID & General Summary Card
                  _buildSummaryMetrics(member),
                  SizedBox(height: 14.h),

                  // 4. Contact Information Card
                  _buildContactCard(member.phone),
                  SizedBox(height: 14.h),

                  // 5. Residential & Administrative Location Card
                  _buildLocationCard(member),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 1. Top Hero Header ---
  Widget _buildHeroHeader(ShgMemberModel member) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 24.h),
          child: Column(
            children: [
              // Avatar
              Container(
                width: 74.r,
                height: 74.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    member.name.isNotEmpty ? member.name[0] : "M",
                    style: GoogleFonts.poppins(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              // Full Name
              Text(
                member.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),

              // Village & Taluka Subtitle
              Text(
                "${member.village}, Taluka: ${member.taluka}",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
              SizedBox(height: 8.h),

              // Enrolled SHG Member Tag
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.white30),
                ),
                child: Text(
                  "SHG Group Member",
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // --- 3. Summary Metric Cards (Age & Member Code) ---
  Widget _buildSummaryMetrics(ShgMemberModel member) {
    return Row(
      children: [
        // Member ID
        Expanded(
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 0.5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Member ID",
                  style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                ),
                SizedBox(height: 2.h),
                Text(
                  "#${member.id}",
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w),

        // Member Age
        Expanded(
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 0.5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Age",
                  style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                ),
                SizedBox(height: 2.h),
                Text(
                  "${member.age} Years",
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- 4. Contact Details Card ---
  Widget _buildContactCard(String phone) {
    return _buildSectionCard(
      title: "CONTACT INFORMATION",
      children: [
        _buildInfoRow(
          icon: Icons.phone_android_rounded,
          title: "Mobile Number",
          value: "+91 $phone",
        ),
      ],
    );
  }

  // --- 5. Location Details Card ---
  Widget _buildLocationCard(ShgMemberModel member) {
    return _buildSectionCard(
      title: "ADMINISTRATIVE & RESIDENTIAL DETAILS",
      children: [
        _buildInfoRow(
          icon: Icons.holiday_village_outlined,
          title: "Village / Town",
          value: member.village,
        ),
        const Divider(height: 18, thickness: 0.6),
        _buildInfoRow(
          icon: Icons.alt_route_rounded,
          title: "Taluka",
          value: member.taluka,
        ),
        const Divider(height: 18, thickness: 0.6),
        _buildInfoRow(
          icon: Icons.location_city_outlined,
          title: "District",
          value: member.district,
        ),
        const Divider(height: 18, thickness: 0.6),
        _buildInfoRow(
          icon: Icons.map_outlined,
          title: "State",
          value: member.state,
        ),
      ],
    );
  }

  // --- Helper: Shared Card Container ---
  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: textMuted,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 12.h),
          ...children,
        ],
      ),
    );
  }

  // --- Helper: Key-Value Row with Icon ---
  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 18.sp, color: primaryColor),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  color: textMuted,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}