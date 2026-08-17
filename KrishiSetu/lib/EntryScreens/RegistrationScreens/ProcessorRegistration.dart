import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/CustomeButton/GreenButton.dart';
import '../../Provider/booleanvalueProvider.dart';
import '../../Widgets/FormFieldTitle.dart';
import '../../Widgets/TextFormField.dart';
import '../../Widgets/buildSectionTitle.dart';
import '../SignInPage.dart';

class Processorregistration extends ConsumerStatefulWidget {
  @override
  ConsumerState<Processorregistration> createState() => _ProcessorregistrationState();
}

class _ProcessorregistrationState extends ConsumerState<Processorregistration> {
  // Persistent GlobalKey so state doesn't reset on obscure toggle
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isObscure = ref.watch(RegistartionpasswordObscureProvider);

    return Scaffold(
      backgroundColor: Color(0xfff8f9fa), // Clean light grey background
      appBar: AppBar(
        backgroundColor: Color(0xff166a20),
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(
          "Processor Registration",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            // Top Green Hero Section Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
              decoration: BoxDecoration(
                color: Color(0xff166a20),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.precision_manufacturing_outlined,
                      color: Colors.white,
                      size: 26.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Processor!",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                        Text(
                          "Source raw millets directly and expand your unit operations",
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
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ==========================================
                        // SECTION 1: CONTACT PERSON & SECURITY
                        // ==========================================
                        buildSectionTitle("👤 Contact Person & Security"),
                        SizedBox(height: 10.h),

                        // Full Name
                        Formfieldtitle(title: "Contact Person Name"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          isObscure: false,
                          errormessage: "Please enter contact person name",
                          hinttext: "Enter full name",
                          prefixicon: Icon(Icons.person_outline, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 14.h),

                        // Mobile Number
                        Formfieldtitle(title: "Mobile Number"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          KeyBoardType: TextInputType.number,
                          isObscure: false,
                          errormessage: "Please enter mobile number",
                          hinttext: "+91 10-digit mobile number",
                          prefixicon: Icon(Icons.phone_outlined, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 14.h),

                        // Email Address
                        Formfieldtitle(title: "Email Address"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          KeyBoardType: TextInputType.emailAddress,
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
                              color: Color(0xff166a20),
                            ),
                          ),
                          isObscure: isObscure,
                          errormessage: "Password length should be at least 8 characters",
                          hinttext: "At least 8 characters",
                          prefixicon: Icon(Icons.lock_outline, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 14.h),

                        // Confirm Password
                        Formfieldtitle(title: "Confirm Password"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          isObscure: isObscure,
                          errormessage: "Password does not match",
                          hinttext: "Confirm your password",
                          prefixicon: Icon(Icons.lock_outline, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 20.h),

                        // ==========================================
                        // SECTION 2: PROCESSING UNIT DETAILS
                        // ==========================================
                        buildSectionTitle("🏭 Processing Unit Details"),
                        SizedBox(height: 10.h),

                        // Unit/Company Name
                        Formfieldtitle(title: "Processing Unit / Business Name"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          isObscure: false,
                          errormessage: "Please enter processing unit name",
                          hinttext: "e.g. Shree Grain Processors Ltd.",
                          prefixicon: Icon(Icons.factory_outlined, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 14.h),

                        // FSSAI / License Number
                        Formfieldtitle(title: "FSSAI / License Number"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          isObscure: false,
                          errormessage: "Please enter license or FSSAI number",
                          hinttext: "e.g. 14-digit FSSAI Reg. No.",
                          prefixicon: Icon(Icons.verified_user_outlined, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 14.h),

                        // Primary Processing Type
                        Formfieldtitle(title: "Processing Specialty / Type"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          isObscure: false,
                          errormessage: "Please specify processing type",
                          hinttext: "e.g. De-husking, Flour Milling, Ready-to-Eat Products",
                          prefixicon: Icon(Icons.precision_manufacturing_outlined, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 14.h),

                        // Processing Capacity
                        Formfieldtitle(title: "Processing Capacity (Tons / Quintals per month)"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          isObscure: false,
                          errormessage: "Please enter processing capacity",
                          hinttext: "e.g. 50 Tons/Month",
                          prefixicon: Icon(Icons.speed_outlined, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 20.h),

                        // ==========================================
                        // SECTION 3: LOCATION DETAILS
                        // ==========================================
                        buildSectionTitle("📍 Facility Location Details"),
                        SizedBox(height: 10.h),

                        // Facility Address
                        Formfieldtitle(title: "Facility Address & Location"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          isObscure: false,
                          errormessage: "Please enter facility address",
                          hinttext: "MIDC / Industrial Area, City, District & State",
                          prefixicon: Icon(Icons.location_on_outlined, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 26.h),

                        // Submit Button
                        Greenbutton(
                          btname: "Create Processor Account",
                          btfunction: () {
                            if (_formKey.currentState!.validate()) {
                              print("Processor registration form validated successfully!");
                            } else {
                              print("Data not entered completely");
                            }
                          },
                          btwidth: double.infinity,
                          btheight: 45.sp,
                          textsize: 14.sp,
                        ),
                        SizedBox(height: 12.h),

                        // Navigation to Sign In
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
                                  color: Color(0xff166a20),
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