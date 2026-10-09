import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmerDashboard  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.green,
        foregroundColor: Colors.white,
        title: Text("Framer Dashboard!",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.sp),),
      ),
      body: Container(),
    );
  }
}