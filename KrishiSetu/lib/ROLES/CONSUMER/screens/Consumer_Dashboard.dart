import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsumerDashboard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Text("Consumer  DashBoard",style:  TextStyle(color: Colors.black,fontSize: 50.sp),),
       ),
    );
  }
}