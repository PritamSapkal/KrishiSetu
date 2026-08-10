import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Formfieldtitle extends StatelessWidget{
  Formfieldtitle({required this.title,super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title,style: GoogleFonts.poppins(color:Colors.black,fontSize: 12.sp));
  }
}