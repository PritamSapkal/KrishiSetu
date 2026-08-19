import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Morescreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F9FA),
      body: Container(
        child: Center(
          child: Text("MoreScreen", style:  TextStyle( color:  Colors.black,fontSize: 30.sp),),
        ),
      ),
    );
  }
}