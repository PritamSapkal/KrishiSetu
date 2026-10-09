import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsumerDashboard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        foregroundColor: Colors.black,
        title: Text("Consumer Dashboard!",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15.sp),),
      ),
      body: Container(),
    );
  }
}