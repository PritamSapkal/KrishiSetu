import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../auth/views/Signinpage.dart';
import '../dummydata/MockShgData.dart'; // Adjust import path to your Signinpage

class SHGProfilescreen extends StatelessWidget {
  const SHGProfilescreen({super.key});

  static const Color primaryColor = Color(0xff880D4F);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);
  static const Color cardSubBg = Color(0xffFAF0E6);

  @override
  Widget build(BuildContext context) {
    final user = MockShgData.mockShgAuth.user;
    final profile = MockShgData.mockShgProfile;

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            // 1. Top Header Banner with Profile Avatar
            _buildHeroHeader(user?.name, profile.shgName, user?.role),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              child: Column(
                children: [
                  // 2. Quick Group Reach Metric
                  _buildQuickStats(profile.numberOfMembers?.toInt() ?? 0),
                  SizedBox(height: 14.h),

                  // 3. Contact Details Card
                  _buildContactCard(user?.email, user?.phone),
                  SizedBox(height: 14.h),

                  // 4. SHG Group & Registration Card
                  _buildOrganizationCard(profile),
                  SizedBox(height: 14.h),

                  // 5. Registered Location Card
                  _buildLocationCard(profile),
                  SizedBox(height: 20.h),

                  // 6. Logout Button
                  _buildLogoutButton(context),
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
  Widget _buildHeroHeader(String? name, String? groupName, String? role) {
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
                    (name != null && name.isNotEmpty) ? name[0] : "S",
                    style: GoogleFonts.poppins(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              // Representative Name
              Text(
                name ?? "Authorized Representative",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2.h),

              // Bachat Gat Name
              Text(
                groupName ?? "Mahila Samruddhi Bachat Gat",
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
                  role ?? "SHG",
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

  // --- 2. Quick Key Metric ---
  Widget _buildQuickStats(int totalMembers) {
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
                  Icons.groups_3_outlined,
                  color: primaryColor,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Self Help Group Size",
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      color: textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "$totalMembers Registered Members",
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
                color: const Color(0xff2E7D32),
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
          icon: Icons.email_outlined,
          title: "Email Address",
          value: email ?? "N/A",
        ),
        const Divider(height: 18, thickness: 0.6),
        _buildInfoRow(
          icon: Icons.phone_android_rounded,
          title: "Mobile Number",
          value: phone != null ? "+91 $phone" : "N/A",
        ),
      ],
    );
  }

  // --- 4. Group & Registration Card ---
  Widget _buildOrganizationCard(dynamic profile) {
    return _buildSectionCard(
      title: "SHG DETAILS & CERTIFICATION",
      children: [
        _buildInfoRow(
          icon: Icons.diversity_1_outlined,
          title: "Group Name",
          value: profile.shgName ?? "N/A",
        ),
        const Divider(height: 18, thickness: 0.6),
        _buildInfoRow(
          icon: Icons.badge_outlined,
          title: "Registration Number",
          value: profile.groupRegistrationNumber ?? "N/A",
        ),
        const Divider(height: 18, thickness: 0.6),
        _buildInfoRow(
          icon: Icons.work_outline_rounded,
          title: "Primary Activity",
          value: (profile.primaryActivity ?? "N/A").replaceAll("_", " "),
        ),
        const Divider(height: 18, thickness: 0.6),
        _buildInfoRow(
          icon: Icons.tag_rounded,
          title: "SHG Profile ID",
          value: "#${profile.id?.substring(profile.id.length - 8) ?? 'N/A'}",
        ),
      ],
    );
  }

  // --- 5. Registered Location Card ---
  Widget _buildLocationCard(dynamic profile) {
    return _buildSectionCard(
      title: "REGISTERED LOCATION",
      children: [
        _buildInfoRow(
          icon: Icons.holiday_village_outlined,
          title: "Village / Town",
          value: profile.village ?? "N/A",
        ),
        const Divider(height: 18, thickness: 0.6),
        _buildInfoRow(
          icon: Icons.alt_route_rounded,
          title: "Taluka",
          value: profile.taluka ?? "N/A",
        ),
        const Divider(height: 18, thickness: 0.6),
        _buildInfoRow(
          icon: Icons.location_city_outlined,
          title: "District & State",
          value: "${profile.district ?? ''}, ${profile.state ?? ''}",
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
            "Are you sure you want to log out of your SHG account?",
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
                Navigator.pop(dialogContext); // Close dialog

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