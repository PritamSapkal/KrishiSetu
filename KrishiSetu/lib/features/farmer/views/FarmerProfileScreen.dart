import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../auth/views/Signinpage.dart';
import '../dummydata/mock_farmer_data.dart';
import '../models/millet_type.dart';

class FarmerProfileScreen extends ConsumerWidget {
  const FarmerProfileScreen({super.key});

  static const Color primaryColor = Color(0xff2E7D32);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);
  static const Color cardSubBg = Color(0xffE8F5E9);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = MockFarmerData.mockFarmerAuth.user;
    final profile = MockFarmerData.mockFarmerProfile;

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            // 1. Top Farmer Header Banner
            _buildHeroHeader(user?.name, profile.village, user?.role),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              child: Column(
                children: [
                  // 2. Land Holding & Crop Size Summary Card
                  _buildLandHoldingCard(
                    profile.farmSize ?? 1.0,
                    profile.farmSizeUnit ?? "ACRE",
                    profile.milletCrops?.length ?? 0,
                  ),
                  SizedBox(height: 14.h),

                  // 3. Contact Information Card
                  _buildContactCard(user?.email, user?.phone),
                  SizedBox(height: 14.h),

                  // 4. Cultivated Millet Varieties Card
                  _buildMilletCropsCard(profile.milletCrops ?? []),
                  SizedBox(height: 14.h),

                  // 5. Farm & Village Location Card
                  _buildLocationCard(profile),
                  SizedBox(height: 20.h),

                  // 6. Logout Button
                  _buildLogoutButton(context),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 1. Top Farmer Header Banner ---
  Widget _buildHeroHeader(String? name, String? village, String? role) {
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
          padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 24.h),
          child: Column(
            children: [
              // Avatar
              Container(
                width: 76.r,
                height: 76.r,
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
                    (name != null && name.isNotEmpty) ? name[0] : "F",
                    style: GoogleFonts.poppins(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              // Farmer Full Name
              Text(
                name ?? "Registered Farmer",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2.h),

              // Village Tag
              Text(
                village != null ? "Village: $village" : "Sangli Region",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              SizedBox(height: 8.h),

              // Role Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.white30),
                ),
                child: Text(
                  role ?? "FARMER",
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- 2. Land Holding Metric Card ---
  Widget _buildLandHoldingCard(num farmSize, String unit, int cropCount) {
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
          Row(
            children: [
              Container(
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  color: cardSubBg,
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Icon(
                  Icons.landscape_outlined,
                  color: primaryColor,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Agricultural Landholding",
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      color: textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "$farmSize $unit ($cropCount Crops Enrolled)",
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: const Color(0xffEAF7ED),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              "Active",
              style: GoogleFonts.poppins(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 3. Contact Details Card ---
  Widget _buildContactCard(String? email, String? phone) {
    return _buildSectionCard(
      title: "CONTACT INFORMATION",
      children: [
        _buildInfoRow(
          icon: Icons.phone_android_rounded,
          title: "Primary Mobile Number",
          value: phone != null ? "+91 $phone" : "N/A",
        ),
        const Divider(height: 18, thickness: 0.6),
        _buildInfoRow(
          icon: Icons.email_outlined,
          title: "Registered Email ID",
          value: email ?? "N/A",
        ),
      ],
    );
  }

  // --- 4. Cultivated Millet Varieties Card ---
  Widget _buildMilletCropsCard(List<String> milletCrops) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "CULTIVATED SHREE ANNA / MILLETS",
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: textMuted,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 12.h),
          milletCrops.isEmpty
              ? Text(
            "No millet crops listed yet",
            style: GoogleFonts.poppins(fontSize: 11.sp, color: textMuted),
          )
              : Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: milletCrops.map((cropName) {
              final milletEnum = MilletType.fromString(cropName);
              return Container(
                padding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: cardSubBg,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: primaryColor.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.grass_outlined,
                        size: 14.sp, color: primaryColor),
                    SizedBox(width: 6.w),
                    Text(
                      milletEnum.displayName,
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // --- 5. Location Card ---
  Widget _buildLocationCard(dynamic profile) {
    return _buildSectionCard(
      title: "FARM & VILLAGE LOCATION",
      children: [
        _buildInfoRow(
          icon: Icons.holiday_village_outlined,
          title: "Village / Gram Panchayat",
          value: profile.village ?? "N/A",
        ),
        const Divider(height: 18, thickness: 0.6),
        _buildInfoRow(
          icon: Icons.alt_route_rounded,
          title: "Taluka / Block",
          value: profile.taluka ?? "N/A",
        ),
        const Divider(height: 18, thickness: 0.6),
        _buildInfoRow(
          icon: Icons.location_city_outlined,
          title: "District & State",
          value: "${profile.district ?? ''}, ${profile.state ?? ''}",
        ),
        const Divider(height: 18, thickness: 0.6),
        _buildInfoRow(
          icon: Icons.tag_rounded,
          title: "Farmer Account ID",
          value: "#${profile.id?.substring(profile.id.length - 8) ?? 'N/A'}",
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
            blurRadius: 5,
            spreadRadius: 1,
          )
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

  // --- 6. Logout Button with Confirmation Dialog ---
  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46.h,
      child: OutlinedButton.icon(
        onPressed: () => _showLogoutDialog(context),
        icon: Icon(Icons.logout_rounded, color: Colors.red.shade700, size: 18.sp),
        label: Text(
          "Log Out",
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Colors.red.shade700,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.red.shade200, width: 1.2),
          backgroundColor: Colors.red.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          title: Text(
            "Confirm Logout",
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          content: Text(
            "Are you sure you want to log out of your Farmer account?",
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: textMuted,
            ),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: textMuted,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                // Clear route stack and redirect to Signinpage
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Signinpage()),
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                "Yes, Logout",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}