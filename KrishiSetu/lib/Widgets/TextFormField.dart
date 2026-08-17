import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Textformfieldwidget extends StatelessWidget{
  Textformfieldwidget({this.onSaved,this.validator,this.controller,this.KeyBoardType,this.errormessage,this.hinttext,this.suffixicon, this.prefixicon, required this.isObscure,super.key});
  final IconButton ? suffixicon;
  final bool isObscure;
  final Icon ? prefixicon;
  final String ? hinttext;
  final String? errormessage;
  final TextInputType? KeyBoardType;
  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.green,
      controller: controller,
      keyboardType: KeyBoardType,
      style:GoogleFonts.poppins(color: Colors.black),
      obscureText: isObscure,
      obscuringCharacter: "*",
      //maxLines:10,
      validator: validator ??
              (value) {
            if (value == null || value.trim().isEmpty) {
              return errormessage;
            }
            return null;
          },

      onSaved: onSaved,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 15.h,   // Decreasing this lowers the height
        ),
        hintText: hinttext,
        hintStyle: GoogleFonts.poppins(fontSize: 13.sp,wordSpacing:2.sp,color: Colors.grey,fontWeight: FontWeight.w500),
        prefixIcon: prefixicon,
        suffixIcon: suffixicon,
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              color: Colors.grey,
              width: 0.2
          ),

        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Color(0xff00D100),
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Color(0xff00D100),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              color: Colors.grey,
              width: 0.2
          ),

        ),
      ),
    );
  }
}