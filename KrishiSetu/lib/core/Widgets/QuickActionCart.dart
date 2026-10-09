import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Iconcart.dart';
import 'customTitle.dart';

class Quickactioncart extends StatelessWidget{
   Quickactioncart({required this.label,required this.icon,required this.iconcolor, required this.iconsize,super.key});
  final IconData icon;
   final Color iconcolor;
   final double iconsize;
   final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(
              spreadRadius: 1,
              blurRadius: 5,
              color: Colors.black12
          )]
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Spacer(),
              Iconcart(icon: icon,color:iconcolor ,iconsize: iconsize,),
              Spacer(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Customtitle(title: label,size:10.sp ,),
          ),
        ],
      )
    );
  }
}