// Helper widget to render Section Heading banners
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildSectionTitle(String title) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0xff166a20).withOpacity(0.08),
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: const Color(0xff166a20).withOpacity(0.2)),
    ),
    child: Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xff166a20),
      ),
    ),
  );
}
