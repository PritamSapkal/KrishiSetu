import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../CustomeButton/GreenButton.dart';
import '../../Provider/booleanvalueProvider.dart';
import '../../Widgets/FormFieldTitle.dart';
import '../../Widgets/TextFormField.dart';
import '../SignInPage.dart';

class Consumerregistration extends ConsumerStatefulWidget {
  const Consumerregistration({super.key});

  @override
  ConsumerState<Consumerregistration> createState() => _ConsumerregistrationState();
}

class _ConsumerregistrationState extends ConsumerState<Consumerregistration> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isObscure = ref.watch(RegistartionpasswordObscureProvider);

    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa), // Clean soft grey background
      appBar: AppBar(
        backgroundColor: const Color(0xff166a20),
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(
          "Consumer Registration",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            // Top Green Hero Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
              decoration: const BoxDecoration(
                color: Color(0xff166a20),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Consumer!",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                            Text(
                              "Create an account to buy fresh produce directly",
                              style: GoogleFonts.poppins(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 11.5.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Form Container Card
            Transform.translate(
              offset: Offset(0, -10.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Full Name
                         Formfieldtitle(title: "Full Name"),
                        SizedBox(height: 6.h),
                         Textformfieldwidget(
                          isObscure: false,
                          errormessage: "Please enter your full name",
                          hinttext: "Enter your full name",
                          prefixicon: Icon(Icons.person_outline, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 14.h),

                        // Mobile Number
                         Formfieldtitle(title: "Mobile Number"),
                        SizedBox(height: 6.h),
                         Textformfieldwidget(
                          isObscure: false,
                          errormessage: "Please enter your mobile number",
                          hinttext: "+91 10-digit mobile number",
                          prefixicon: Icon(Icons.phone_outlined, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 14.h),

                        // Email Address
                         Formfieldtitle(title: "Email Address"),
                        SizedBox(height: 6.h),
                         Textformfieldwidget(
                          isObscure: false,
                          errormessage: "Please enter valid email address",
                          hinttext: "Enter e-mail address",
                          prefixicon: Icon(Icons.mail_outline_sharp, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 14.h),

                        // Set Password
                         Formfieldtitle(title: "Set Password"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          suffixicon: IconButton(
                            onPressed: () {
                              ref
                                  .read(RegistartionpasswordObscureProvider.notifier)
                                  .update((state) => !state);
                            },
                            icon: Icon(
                              isObscure
                                  ? Icons.visibility_off_sharp
                                  : Icons.remove_red_eye,
                              color: const Color(0xff166a20),
                            ),
                          ),
                          isObscure: isObscure,
                          errormessage: "Password length should be at least 8 characters",
                          hinttext: "At least 8 characters",
                          prefixicon: const Icon(Icons.lock_outline, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 14.h),

                        // Confirm Password
                         Formfieldtitle(title: "Confirm Password"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          isObscure: isObscure,
                          errormessage: "Password does not match",
                          hinttext: "Confirm your password",
                          prefixicon: const Icon(Icons.lock_outline, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 24.h),

                        // Create Account Button
                        Greenbutton(
                          btname: "Create Account & Continue",
                          btfunction: () {
                            if (_formKey.currentState!.validate()) {
                              // Action after successful validation
                            } else {
                              print("Data not entered completely");
                            }
                          },
                          btwidth: double.infinity,
                          btheight: 45.sp,
                          textsize: 14.sp,
                        ),

                        SizedBox(height: 12.h),

                        // Already Have Account Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: GoogleFonts.poppins(
                                color: Colors.grey.shade600,
                                fontSize: 12.5.sp,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => Signinpage()),
                                );
                              },
                              child: Text(
                                "Sign In",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff166a20),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.5.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}