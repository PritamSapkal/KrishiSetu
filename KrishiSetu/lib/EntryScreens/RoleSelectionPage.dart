import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/CustomeButton/GreenButton.dart';
import '../Data/RollDataList.dart';

class Roleselectionpage extends StatefulWidget {
  const Roleselectionpage({super.key});

  @override
  State<Roleselectionpage> createState() => _RoleselectionpageState();
}

class _RoleselectionpageState extends State<Roleselectionpage> {
  // Holds the currently selected role index
  int? selectedRoleIndex;

  // Role Configuration List
  final List<Map<String, dynamic>> roles = rolesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: const Color(0xff166a20),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Header Banner
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 25.h),
            decoration: const BoxDecoration(
              color: Color(0xff166a20),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "I am a...",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Choose your role to personalize your platform experience.",
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),

          // Role Option Cards
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
              itemCount: roles.length,
              itemBuilder: (context, index) {
                final role = roles[index];
                final isSelected = selectedRoleIndex == index;

                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xff166a20).withOpacity(0.04) : Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: isSelected ? const Color(0xff166a20) : Colors.grey.shade300,
                        width: isSelected ? 2.0 : 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14.r),
                      onTap: () {
                        setState(() {
                          selectedRoleIndex = index;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(14.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Colored Category Icon Box
                            Container(
                              height: 46.w,
                              width: 46.w,
                              decoration: BoxDecoration(
                                color: (role['color'] as Color).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: FaIcon(
                                  role['icon'],
                                  color: role['color'] as Color,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 14.w),

                            // Role Text Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          role['title'],
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.sp,
                                            color: isSelected ? const Color(0xff166a20) : Colors.black87,
                                          ),
                                        ),
                                      ),
                                      // Radio Selection Checkmark Indicator
                                      Icon(
                                        isSelected
                                            ? Icons.check_circle
                                            : Icons.radio_button_unchecked,
                                        color: isSelected
                                            ? const Color(0xff166a20)
                                            : Colors.grey.shade400,
                                        size: 20.sp,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    role['description'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 11.5.sp,
                                      color: Colors.grey.shade600,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom Fixed Action Bar (Continue Button)
          Container(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Opacity(
              opacity: selectedRoleIndex != null ? 1.0 : 0.5,
              child: Greenbutton(
                btname: "Continue",
                btfunction: () {
                  if (selectedRoleIndex != null) {
                    final targetScreen = roles[selectedRoleIndex!]['screen'] as Widget;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => targetScreen),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please select a role to continue",
                          style: GoogleFonts.poppins(),
                        ),
                        backgroundColor: Colors.black87,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                btwidth: double.infinity,
                btheight: 45.sp,
                textsize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}