import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ProcessorProfileScreen extends StatelessWidget {
  const ProcessorProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xffF8F9FA),
      body: Center(
        child: Text("ProfileScreen",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25.sp),),
      ),
    );
  }
}