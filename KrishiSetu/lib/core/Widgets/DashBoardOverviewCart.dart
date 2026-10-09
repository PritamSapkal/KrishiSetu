import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Iconcart.dart';
import 'customTitle.dart';

class Dashboardoverviewcart extends StatelessWidget{
  Dashboardoverviewcart({required this.widget,required this.carttitle,required this.icon, required this.iconColor,});
  final String carttitle;
  final IconData icon;
  final Color iconColor;
  Widget widget;

  @override
  Widget build(BuildContext context) {
    return   Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(
                spreadRadius: 1,
                blurRadius: 5,
                color: Colors.black12
            )]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  child: Text(carttitle,style: GoogleFonts.poppins(color: Color(0xff59606C),fontWeight: FontWeight.w600,fontSize: 12.sp),),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 8),
                  child: Iconcart(icon:icon,iconsize:20.sp,color: iconColor,),
                ),

              ],
            ),
            Center(child: widget)
          ],


        ),

    );
  }
}