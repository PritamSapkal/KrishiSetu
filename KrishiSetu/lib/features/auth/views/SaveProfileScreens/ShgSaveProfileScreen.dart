import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/Widgets/CustomeButton/GreenButton.dart';
import '../../../../core/Widgets/FormFieldTitle.dart';
import '../../../../core/Widgets/TextFormField.dart';
import '../SignInPage.dart';

class ShgSaveProfileScreen extends ConsumerStatefulWidget {
  const ShgSaveProfileScreen({super.key});

  @override
  ConsumerState<ShgSaveProfileScreen> createState() => _ShgSaveProfileScreenState();
}

class _ShgSaveProfileScreenState extends ConsumerState<ShgSaveProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers mapping to the backend fields
  final TextEditingController _shgNameController = TextEditingController();
  final TextEditingController _groupRegistrationNumberController = TextEditingController();
  final TextEditingController _numberOfMembersController = TextEditingController();
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
    _shgNameController.dispose();
    _groupRegistrationNumberController.dispose();
    _numberOfMembersController.dispose();
    _villageController.dispose();
    _talukaController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _generateShgJson() {
    return {
      "shgName": _shgNameController.text.trim(),
      "groupRegistrationNumber": _groupRegistrationNumberController.text.trim().isEmpty
          ? null
          : _groupRegistrationNumberController.text.trim(),
      "village": _villageController.text.trim(),
      "taluka": _talukaController.text.trim(),
      "district": _districtController.text.trim(),
      "state": _stateController.text.trim(),
      "numberOfMembers": int.tryParse(_numberOfMembersController.text.trim()) ?? 0,
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
          "Complete SHG Profile",
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

            // Form Body in Modular Cards
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Card 1: SHG (Bachat Gat) Details
                    _buildCardContainer(
                      title: "Self Help Group (बचत गट) Details",
                      subtitle: "Group identification and member strength",
                      icon: Icons.groups_2_outlined,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SHG Name (@NotBlank)
                          Formfieldtitle(title: "SHG / Bachat Gat Name *"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _shgNameController,
                            isObscure: false,
                            errormessage: "SHG name is required",
                            hinttext: "e.g. Jijau Mahila Bachat Gat",
                            prefixicon: const Icon(Icons.groups_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 14.h),

                          // Group Registration Number (Optional)
                          Formfieldtitle(title: "Group Registration Number (Optional)"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _groupRegistrationNumberController,
                            isObscure: false,
                            hinttext: "Govt Reg. No. / Bank Linkage ID",
                            prefixicon: const Icon(Icons.badge_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 14.h),

                          // Number of Members (@Positive)
                          Formfieldtitle(title: "Number of Members *"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _numberOfMembersController,
                            KeyBoardType: TextInputType.number,
                            isObscure: false,
                            hinttext: "e.g. 10 or 15",
                            prefixicon: const Icon(Icons.people_alt_outlined, color: primaryGreen),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter number of members";
                              }
                              final count = int.tryParse(value.trim());
                              if (count == null || count <= 0) {
                                return "Number of members must be greater than 0";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // Card 2: SHG Location Details
                    _buildCardContainer(
                      title: "Group Location & Operational Base",
                      subtitle: "Administrative base where the group operates",
                      icon: Icons.location_on_outlined,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Village (@NotBlank)
                          Formfieldtitle(title: "Village *"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _villageController,
                            isObscure: false,
                            errormessage: "Village is required",
                            hinttext: "e.g. Padmale / Sangli",
                            prefixicon: const Icon(Icons.home_work_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 14.h),

                          // Taluka (@NotBlank)
                          Formfieldtitle(title: "Taluka *"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _talukaController,
                            isObscure: false,
                            errormessage: "Taluka is required",
                            hinttext: "e.g. Miraj",
                            prefixicon: const Icon(Icons.near_me_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 14.h),

                          // District (@NotBlank)
                          Formfieldtitle(title: "District *"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _districtController,
                            isObscure: false,
                            errormessage: "District is required",
                            hinttext: "e.g. Sangli",
                            prefixicon: const Icon(Icons.location_city_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 14.h),

                          // State (@NotBlank)
                          Formfieldtitle(title: "State *"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _stateController,
                            isObscure: false,
                            errormessage: "State is required",
                            hinttext: "e.g. Maharashtra",
                            prefixicon: const Icon(Icons.public_outlined, color: primaryGreen),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Submit CTA Button
                    Greenbutton(
                      btname: "Save SHG Profile",
                      btfunction: () {
                        if (_formKey.currentState!.validate()) {
                          final payload = _generateShgJson();
                          debugPrint("Saving SHG Profile JSON: $payload");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: primaryGreen,
                              content: Text("SHG profile details saved successfully!"),
                            ),
                          );
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signinpage()));
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

  // --- Top Hero Header Banner ---
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
              Icons.people_alt_outlined,
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
                  "Set Up SHG Profile",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                ),
                Text(
                  "Empower Bachat Gat members to trade and market local millet goods",
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

  // --- Reusable Clean Card Container ---
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