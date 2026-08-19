import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Farmersscreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("FarmerScreen", style:  TextStyle( color:  Colors.black,fontSize: 30.sp),),
        ),
      ),
    );
  }
}