import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ProcessorProductScreen extends StatelessWidget {
  const ProcessorProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xffF8F9FA),
      body: Center(
        child: Text("ProductScreen",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25.sp),),
      ),
    );
  }
}