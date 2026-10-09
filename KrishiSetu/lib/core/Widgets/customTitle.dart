import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Customtitle extends StatelessWidget{
  Customtitle({required this.title,required this.size,super.key});
  final String title;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(title,style: GoogleFonts.poppins(color:Colors.black,fontSize: size,fontWeight: FontWeight.w600,));
  }
}