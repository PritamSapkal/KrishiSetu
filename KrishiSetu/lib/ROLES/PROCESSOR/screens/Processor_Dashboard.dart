import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProcessorDashboard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:  Center(
         child: Text("Processor  DashBoard",style:  TextStyle(color: Colors.black,fontSize: 50.sp),),
       ),
    );
  }
}