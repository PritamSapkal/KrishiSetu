import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class FarmerProduceScreen extends StatelessWidget {
  const FarmerProduceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("ProduceScreen ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25.sp),),
      ),
    );
  }
}