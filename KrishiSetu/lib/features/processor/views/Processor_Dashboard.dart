import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProcessorDashboard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xff4A148C),
        foregroundColor: Colors.white,
        title: Text("Processor Dashboard!",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.sp),),
      ),
      body: Container(),
    );
  }
}