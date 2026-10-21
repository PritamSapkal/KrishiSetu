import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class FarmerOrderScreen extends StatelessWidget {
  const FarmerOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("OrderScreen",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25.sp),),
      ),
    );
  }
}