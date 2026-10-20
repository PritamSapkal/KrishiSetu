import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Processorhomescreen extends StatelessWidget {
  const Processorhomescreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xffF8F9FA),
      body: Center(
        child: Text("HomeScreen",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25.sp),),
      ),
    );
  }
}
