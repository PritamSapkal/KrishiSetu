import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../auth/views/Signinpage.dart';
import '../viewmodels/buyer_order_riverpod.dart';

class BuyerProfileScreen extends ConsumerWidget {
  const BuyerProfileScreen({super.key});

  static const Color primaryColor = Color(0xff004D40); // Deep Emerald Teal
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(buyerOrderListProvider);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            // Top Emerald Banner
            Container(
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
                      Container(
                        width: 76.r,
                        height: 76.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: Center(
                          child: Text(
                            "P",
                            style: GoogleFonts.poppins(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Pritam Sapkal",
                        style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "buyer@gmail.com • +91 9876543210",
                        style: GoogleFonts.poppins(fontSize: 11.sp, color: Colors.white70),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          "VERIFIED BUYER",
                          style: GoogleFonts.poppins(fontSize: 10.sp, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              child: Column(
                children: [
                  // Order History Metric Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 0.5)],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: const BoxDecoration(color: Color(0xffE0F2F1), shape: BoxShape.circle),
                              child: const Icon(Icons.shopping_bag_outlined, color: primaryColor),
                            ),
                            SizedBox(width: 12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Purchases", style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted)),
                                Text("${orders.length} Orders Placed", style: GoogleFonts.poppins(fontSize: 13.sp, fontWeight: FontWeight.bold, color: textDark)),
                              ],
                            ),
                          ],
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),

                  // Saved Shipping Address
                  _buildSectionCard(
                    title: "DEFAULT SHIPPING ADDRESS",
                    children: [
                      _buildInfoRow(Icons.location_on_outlined, "Address", "Plot No. 12, APMC Market Road"),
                      const Divider(height: 16, thickness: 0.6),
                      _buildInfoRow(Icons.location_city_outlined, "City & State", "Sangli, Maharashtra"),
                      const Divider(height: 16, thickness: 0.6),
                      _buildInfoRow(Icons.pin_drop_outlined, "Pin Code", "416416"),
                    ],
                  ),
                  SizedBox(height: 14.h),

                  // App Information
                  _buildSectionCard(
                    title: "PLATFORM DETAILS",
                    children: [
                      _buildInfoRow(Icons.eco_outlined, "Platform", "KrishiSetu Millet Ecosystem"),
                      const Divider(height: 16, thickness: 0.6),
                      _buildInfoRow(Icons.info_outline, "Version", "v1.0.0 (Production Release)"),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: 46.h,
                    child: OutlinedButton.icon(
                      onPressed: () => _showLogoutDialog(context),
                      icon: Icon(Icons.logout_rounded, color: Colors.red.shade700, size: 18.sp),
                      label: Text(
                        "Log Out",
                        style: GoogleFonts.poppins(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.red.shade700),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.red.shade200),
                        backgroundColor: Colors.red.shade50,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 0.5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 10.sp, fontWeight: FontWeight.bold, color: textMuted, letterSpacing: 0.5)),
          SizedBox(height: 10.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: primaryColor),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted)),
              Text(value, style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w600, color: textDark)),
            ],
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        title: Text("Confirm Logout", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16.sp)),
        content: Text("Are you sure you want to log out of your Buyer account?", style: GoogleFonts.poppins(fontSize: 12.sp)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Signinpage()),
                    (route) => false,
              );
            },
            child: const Text("Yes, Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}