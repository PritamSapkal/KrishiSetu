import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../CustomeButton/GreenButton.dart';
import '../../Provider/booleanvalueProvider.dart';
import '../../Widgets/FormFieldTitle.dart';
import '../../Widgets/TextFormField.dart';
import '../../Widgets/buildSectionTitle.dart';
import '../SignInPage.dart';

class Farmerregistration extends ConsumerStatefulWidget {
  const Farmerregistration({super.key});

  @override
  ConsumerState<Farmerregistration> createState() => _FarmerregistrationState();
}

class _FarmerregistrationState extends ConsumerState<Farmerregistration> {
  // Persistent GlobalKey declared inside State so form state persists across rebuilds
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
          "Farmer Registration",
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
            // Top Green Hero Section Header
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
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.agriculture_outlined,
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
                          "Welcome Farmer!",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                        Text(
                          "Register to sell crops directly at fair market prices",
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
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ==========================================
                        // SECTION 1: PERSONAL & SECURITY DETAILS
                        // ==========================================
                        buildSectionTitle("👤 Personal & Security Details"),
                        SizedBox(height: 10.h),

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
                        SizedBox(height: 20.h),

                        // ==========================================
                        // SECTION 2: LOCATION DETAILS
                        // ==========================================
                        buildSectionTitle("📍 Location Details"),
                        SizedBox(height: 10.h),

                        // State
                         Formfieldtitle(title: "State"),
                        SizedBox(height: 6.h),
                         Textformfieldwidget(
                          isObscure: false,
                          errormessage: "Please enter state name",
                          hinttext: "e.g. Maharashtra",
                          prefixicon: Icon(Icons.map_outlined, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 14.h),

                        // District
                         Formfieldtitle(title: "District"),
                        SizedBox(height: 6.h),
                         Textformfieldwidget(
                          isObscure: false,
                          errormessage: "Please enter district name",
                          hinttext: "e.g. Sangli / Kolhapur",
                          prefixicon: Icon(Icons.location_city_outlined, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 14.h),

                        // Taluka
                         Formfieldtitle(title: "Taluka"),
                        SizedBox(height: 6.h),
                         Textformfieldwidget(
                          isObscure: false,
                          errormessage: "Please enter taluka name",
                          hinttext: "Enter your taluka",
                          prefixicon: Icon(Icons.near_me_outlined, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 14.h),

                        // Village
                         Formfieldtitle(title: "Village"),
                        SizedBox(height: 6.h),
                         Textformfieldwidget(
                          isObscure: false,
                          errormessage: "Please enter village name",
                          hinttext: "Enter your village name",
                          prefixicon: Icon(Icons.home_work_outlined, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 20.h),

                        // ==========================================
                        // SECTION 3: FARM DETAILS
                        // ==========================================
                        buildSectionTitle("🌾 Farm Details"),
                        SizedBox(height: 10.h),

                        // Farm Area
                         Formfieldtitle(title: "Farm Area (in Acres/Guntha)"),
                        SizedBox(height: 6.h),
                         Textformfieldwidget(
                          isObscure: false,
                          errormessage: "Please enter valid farm area",
                          hinttext: "e.g. 2.5 Acres or 10 Guntha",
                          prefixicon: Icon(Icons.landscape_outlined, color: Color(0xff166a20)),
                        ),
                        SizedBox(height: 26.h),

                        // Submit Button
                        Greenbutton(
                          btname: "Create Farmer Account",
                          btfunction: () {
                            if (_formKey.currentState!.validate()) {
                              print("Farmer registration form validated successfully!");
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