import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Data/FPO_Dummy_Data/farmer_dummy_data.dart';
import '../../../Widgets/Customebackgroundcontainer.dart';

class Farmerinfopage extends StatelessWidget {
  const Farmerinfopage({required this.index, super.key});
  final int index;

  static const Color primaryBrown = Color(0xff8D4F1E);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);
  static const Color cardSubBg = Color(0xffF5F6F8);

  @override
  Widget build(BuildContext context) {
    final farmer = farmerslist[index];

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
          "Farmer Details",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      // Add Contribution button at the bottom
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        color: scaffoldBg,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_circle_outline, color: Colors.white),
          label: Text(
            "Add Contribution",
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBrown,
            elevation: 0,
            minimumSize: Size(double.infinity, 48.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Profile Card
            _buildProfileHeaderCard(farmer),
            SizedBox(height: 14.h),

            // Contact Details Card
            _buildContactDetailsCard(farmer),
            SizedBox(height: 14.h),

            // Farm Overview Card
            _buildFarmOverviewCard(farmer),
            SizedBox(height: 14.h),

            // Registered Produce Section
            _buildRegisteredProduceSection(farmer),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  // --- Profile Card ---
  Widget _buildProfileHeaderCard(dynamic farmer) {
    return Customebackgroundcontainer(
      childwidget:Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            // farmer image
            CircleAvatar(
              radius: 32.r,
              backgroundImage: const NetworkImage(
                'https://images.unsplash.com/photo-1592982537447-7440770cbfc9?w=300',
              ),
            ),
            SizedBox(height: 8.h),

            // Farmer name
            Text(
              farmer.fullName,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),

            SizedBox(height: 6.h),

            // Farmer Id & Active Member Tag.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Farmer Id
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xffEEF2F6),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    farmer.farmerId,
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      color: textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(width: 6.w),
                // Active Member Tag
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xffFDF0E6),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 3.r,
                        backgroundColor: primaryBrown,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "Active Member",
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          color: primaryBrown,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            // Member Since
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today_outlined, size: 12.sp, color: textMuted),
                SizedBox(width: 4.w),
                Text(
                  "Member Since: ${farmer.memberSince}",
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    color: textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Contact Details Card ---
  Widget _buildContactDetailsCard(dynamic farmer) {
    return Customebackgroundcontainer(
        childwidget:Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact Details Text
          Text(
            "Contact Details",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: textDark,
            ),
          ),
          SizedBox(height: 12.h),

          //Mobile Number
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: const Color(0xffF4F5F7),
                child: Icon(Icons.phone_outlined, size: 16.sp, color: primaryBrown),
              ),
              SizedBox(width: 10.w),

              //Mobile Number
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mobile", style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted)),
                  Text(
                    farmer.mobileNumber,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: textDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Location Data
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: const Color(0xffF4F5F7),
                child: Icon(Icons.location_on_outlined, size: 16.sp, color: primaryBrown),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Location", style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted)),

                  // Village Name & PinCode
                  Text(
                    farmer.village+","+farmer.district+"\nPin: "+farmer.pinCode,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: textDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }

  // --- Farm Overview Card ---
  Widget _buildFarmOverviewCard(dynamic farmer) {
    return Customebackgroundcontainer(
        childwidget:Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Brown Line
            Container(
              width: 4.w,
              decoration: BoxDecoration(
                color: primaryBrown,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  bottomLeft: Radius.circular(20.r),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Farm Overview Text
                    Text(
                      "Farm Overview",
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: textDark,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Farm Size & Contribution
                    Row(
                      children: [
                        Expanded(
                          child: _buildMetricTile(
                            icon: Icons.terrain_outlined,
                            title: "Farm Size",
                            value: "${farmer.farmSize}",
                            unit: farmer.farmSizeUnit,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: _buildMetricTile(
                            icon: Icons.scale_outlined,
                            title: "Contribution",
                            value: "${farmer.currentContribution.value}",
                            unit: farmer.currentContribution.unit,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: cardSubBg,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.grass_outlined, size: 13.sp, color: textMuted),
                              SizedBox(width: 4.w),
                              // Primary crop text
                              Text(
                                "Primary Crops",
                                style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),

                          // Crop names
                          Text(
                            farmer.primaryCrops.join(", "),
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
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildMetricTile({
    required IconData icon,
    required String title,
    required String value,
    required String unit,
  }) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: cardSubBg,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 13.sp, color: textMuted),
              SizedBox(width: 4.w),
              Text(
                title,
                style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          RichText(
            text: TextSpan(
              text: value,
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
              children: [
                TextSpan(
                  text: " $unit",
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.normal,
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

  // --- Registered Produce Section ---
  Widget _buildRegisteredProduceSection(dynamic farmer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Registered Produce",
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
        SizedBox(height: 8.h),
        _buildProduceItem(
          name: farmer.primaryCrops[0],
          expectedTimeline: "Expected: Oct-Nov",
          color: const Color(0xffDDE4F0),
        ),
        SizedBox(height: 8.h),
        _buildProduceItem(
          name: farmer.primaryCrops[1],
          expectedTimeline: "Expected: Dec-Jan",
          color: const Color(0xffFDE6D2),
        ),
      ],
    );
  }

  Widget _buildProduceItem({
    required String name,
    required String expectedTimeline,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.eco, size: 18.sp, color: primaryBrown),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: textDark,
                  ),
                ),
                Text(
                  expectedTimeline,
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    color: textMuted,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, size: 18.sp, color: textMuted),
        ],
      ),
    );
  }
}