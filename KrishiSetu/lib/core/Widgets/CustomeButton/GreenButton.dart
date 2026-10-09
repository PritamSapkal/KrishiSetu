import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Greenbutton extends StatelessWidget {
  Greenbutton({required this.btname, required this.btfunction,required this.btwidth,required this.btheight,required this.textsize, super.key});

  final String btname;
  void Function() btfunction;
  final double btwidth;
  final double btheight;
  final double textsize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: btfunction,
      child: Container(
        height: btheight,
        width: btwidth,
        decoration: BoxDecoration(
          color: Color(0xff2E7D32),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 4,
            offset: Offset(0, 2)
          )]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(btname,style:Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: textsize,fontWeight: FontWeight.bold,),
          ),
        ),
      ),
    ));
  }
}
