import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/Widgets/customTitle.dart';
import '../dummydata/ShgMember_DummyData.dart';
import '../models/ShgMemberModel.dart';
import '../viewmodels/MemberListRiverpod.dart';
import 'SHGMemberDetailsPage.dart';
import 'ShgAddMemberScreen.dart';
class SHGMemmberscreen extends ConsumerStatefulWidget {
  const SHGMemmberscreen({super.key});

  @override
  ConsumerState<SHGMemmberscreen> createState() => _SHGMemmberscreenState();
}

class _SHGMemmberscreenState extends ConsumerState<SHGMemmberscreen> {
  static const Color primaryColor = Color(0xff880D4F);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff585F6C);

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter members list by name or village
    final List<ShgMemberModel> filteredMembers = ref.watch(MemberlistProvider).where((member) {
      final query = _searchQuery.toLowerCase();
      final matchesName = member.name.toLowerCase().contains(query);
      final matchesVillage = member.village.toLowerCase().contains(query);
      return matchesName || matchesVillage;
    }).toList();

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.fromLTRB(15.w, 16.h, 15.w, 12.h),
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  _searchQuery = val.trim();
                });
              },
              style: GoogleFonts.poppins(color: textDark, fontSize: 13.sp),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                prefixIcon: Icon(Icons.search_sharp, color: textMuted, size: 20.sp),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = "";
                    });
                  },
                )
                    : null,
                hintText: "Search by member name or village",
                hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 12.sp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: const BorderSide(color: primaryColor, width: 0.8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: const BorderSide(color: primaryColor, width: 1.2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
            ),
          ),

          // Total Members Summary Pill
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            child: Row(
              children: [
                Text(
                  "Total Enrolled Members: ",
                  style: GoogleFonts.poppins(fontSize: 11.sp, color: textMuted),
                ),
                Text(
                  "${filteredMembers.length}",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.h),

          // Member Cards List
          Expanded(
            child: filteredMembers.isEmpty
                ? Center(
              child: Text(
                "No members found",
                style: GoogleFonts.poppins(fontSize: 13.sp, color: textMuted),
              ),
            )
                : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: filteredMembers.length,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
              itemBuilder: (context, index) {
                final member = filteredMembers[index];
                // Fetch actual original index for clean detail screen reference
                final originalIndex = ref.watch(MemberlistProvider).indexOf(member);

                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SHGMemberDetailsPage(
                            index: originalIndex,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: const [
                          BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 4,
                            color: Colors.black12,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Member Avatar
                            CircleAvatar(
                              radius: 22.r,
                              backgroundColor: primaryColor.withOpacity(0.12),
                              child: Text(
                                member.name.isNotEmpty ? member.name[0] : "M",
                                style: GoogleFonts.poppins(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),

                            // Member Information
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Customtitle(
                                    title: member.name,
                                    size: 13.sp,
                                  ),
                                  SizedBox(height: 2.h),

                                  // Village and Taluka
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 13.sp,
                                        color: textMuted,
                                      ),
                                      SizedBox(width: 2.w),
                                      Text(
                                        "${member.village}, ${member.taluka}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 10.sp,
                                          color: textMuted,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),

                                  // Mobile & Age Row
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone_outlined,
                                        size: 12.sp,
                                        color: textMuted,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "+91 ${member.phone}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 10.sp,
                                          color: textDark,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.w,
                                          vertical: 1.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffFAF0E6),
                                          borderRadius: BorderRadius.circular(4.r),
                                        ),
                                        child: Text(
                                          "Age: ${member.age} yrs",
                                          style: GoogleFonts.poppins(
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff8D4F1E),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Forward Arrow
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14.sp,
                              color: Colors.grey.shade400,
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => const ShgAddMemberScreen()));
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

