import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/Widgets/CustomeButton/GreenButton.dart';
import '../../../../core/Widgets/FormFieldTitle.dart';
import '../../../../core/Widgets/TextFormField.dart';

class FpoSaveProfileScreen extends ConsumerStatefulWidget {
  const FpoSaveProfileScreen({super.key});

  @override
  ConsumerState<FpoSaveProfileScreen> createState() => _FpoSaveProfileScreenState();
}

class _FpoSaveProfileScreenState extends ConsumerState<FpoSaveProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers mapping to FPO JSON keys
  final TextEditingController _fpoNameController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController();
  final TextEditingController _numberOfFarmersController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _talukaController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController(text: "Maharashtra");

  static const Color primaryGreen = Color(0xff166a20);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff6C757D);

  @override
  void dispose() {
    _fpoNameController.dispose();
    _registrationNumberController.dispose();
    _numberOfFarmersController.dispose();
    _villageController.dispose();
    _talukaController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _generateFpoJson() {
    return {
      "fpoName": _fpoNameController.text.trim(),
      "registrationNumber": _registrationNumberController.text.trim(),
      "village": _villageController.text.trim(),
      "taluka": _talukaController.text.trim(),
      "district": _districtController.text.trim(),
      "state": _stateController.text.trim(),
      "numberOfFarmers": int.tryParse(_numberOfFarmersController.text.trim()) ?? 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: primaryGreen,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Complete FPO Profile",
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
            // Top Hero Banner
            _buildHeroBanner(),

            // Form Content inside Card Container
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Card 1: FPO Organization Info
                    _buildCardContainer(
                      title: "Organization Details",
                      subtitle: "Official registration and network reach",
                      icon: Icons.business_outlined,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // FPO Name
                          Formfieldtitle(title: "FPO Name"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _fpoNameController,
                            isObscure: false,
                            errormessage: "Please enter FPO name",
                            hinttext: "e.g. Krishi Vikas Producer Company Ltd",
                            prefixicon: const Icon(Icons.apartment_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 14.h),

                          // Registration Number
                          Formfieldtitle(title: "FPO Registration Number"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _registrationNumberController,
                            isObscure: false,
                            errormessage: "Please enter registration number",
                            hinttext: "e.g. FPO-MH-2024-00123",
                            prefixicon: const Icon(Icons.badge_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 14.h),

                          // Number of Associated Farmers
                          Formfieldtitle(title: "Number of Associated Farmers"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _numberOfFarmersController,
                            KeyBoardType: TextInputType.number,
                            isObscure: false,
                            errormessage: "Enter number of connected farmers",
                            hinttext: "e.g. 250",
                            prefixicon: const Icon(Icons.groups_outlined, color: primaryGreen),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // Card 2: Registered Headquarters & Operational Area
                    _buildCardContainer(
                      title: "Headquarters & Location",
                      subtitle: "Operational base of your FPO cluster",
                      icon: Icons.location_on_outlined,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Village / Town
                          Formfieldtitle(title: "Village / Town"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _villageController,
                            isObscure: false,
                            errormessage: "Please enter village / town",
                            hinttext: "e.g. Palus",
                            prefixicon: const Icon(Icons.home_work_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 14.h),

                          // Taluka
                          Formfieldtitle(title: "Taluka"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _talukaController,
                            isObscure: false,
                            errormessage: "Please enter taluka",
                            hinttext: "e.g. Palus",
                            prefixicon: const Icon(Icons.near_me_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 14.h),

                          // District
                          Formfieldtitle(title: "District"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _districtController,
                            isObscure: false,
                            errormessage: "Please enter district",
                            hinttext: "e.g. Sangli",
                            prefixicon: const Icon(Icons.location_city_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 14.h),

                          // State
                          Formfieldtitle(title: "State"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _stateController,
                            isObscure: false,
                            errormessage: "Please enter state",
                            hinttext: "e.g. Maharashtra",
                            prefixicon: const Icon(Icons.public_outlined, color: primaryGreen),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Save Profile CTA Button
                    Greenbutton(
                      btname: "Save FPO Profile",
                      btfunction: () {
                        if (_formKey.currentState!.validate()) {
                          final payload = _generateFpoJson();
                          debugPrint("Saving FPO Profile JSON: $payload");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: primaryGreen,
                              content: Text("FPO profile details saved successfully!"),
                            ),
                          );
                        }
                      },
                      btwidth: double.infinity,
                      btheight: 48.h,
                      textsize: 14.sp,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Top Hero Header ---
  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
      decoration: const BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.corporate_fare_outlined,
              color: Colors.white,
              size: 26.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Set Up FPO Organization",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                ),
                Text(
                  "Establish verified collective trading & farmer aggregation",
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Reusable Section Card Container ---
  Widget _buildCardContainer({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryGreen, size: 20.sp),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w700,
                      color: textDark,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      color: textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 20, thickness: 0.6),
          child,
        ],
      ),
    );
  }
}