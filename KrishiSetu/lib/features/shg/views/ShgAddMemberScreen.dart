import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/Widgets/FormFieldTitle.dart';
import '../../../../core/Widgets/TextFormField.dart';
import '../models/ShgMemberModel.dart';
import '../viewmodels/MemberListRiverpod.dart'; // Adjust path to ShgMemberModel

class ShgAddMemberScreen extends ConsumerStatefulWidget {
  const ShgAddMemberScreen({super.key});

  @override
  ConsumerState<ShgAddMemberScreen> createState() => _ShgAddMemberScreenState();
}

class _ShgAddMemberScreenState extends ConsumerState<ShgAddMemberScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _talukaController = TextEditingController(text: "Palus");
  final TextEditingController _districtController = TextEditingController(text: "Sangli");
  final TextEditingController _stateController = TextEditingController(text: "Maharashtra");

  bool _isSubmitting = false;

  static const Color primaryColor = Color(0xff880D4F);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff585F6C);

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _villageController.dispose();
    _talukaController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  void _submitMember() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please fill in all mandatory fields correctly",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: Colors.red.shade700,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    final newMember = ShgMemberModel(
      id: "MEM${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      state: _stateController.text.trim(),
      district: _districtController.text.trim(),
      taluka: _talukaController.text.trim(),
      village: _villageController.text.trim(),
      age: int.tryParse(_ageController.text.trim()) ?? 0,
    );

    // Insert into mock dummy list so the listing page updates immediately
    ref.read(MemberlistProvider.notifier).addMember(newMember);

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Member enrolled successfully!",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color(0xff2E7D32),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          "Add SHG Member",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Personal Information
              _buildSectionTitle("Personal Information"),
              SizedBox(height: 12.h),

              Formfieldtitle(title: "Member Full Name *"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _nameController,
                isObscure: false,
                hinttext: "e.g., Sunita Ramesh Patil",
                errormessage: "Please enter member's full name",
                prefixicon: const Icon(Icons.person_outline, color: primaryColor),
              ),
              SizedBox(height: 14.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mobile Number
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Formfieldtitle(title: "Mobile Number *"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          controller: _phoneController,
                          isObscure: false,
                          KeyBoardType: TextInputType.phone,
                          hinttext: "e.g., 9822114455",
                          errormessage: "Enter phone",
                          prefixicon: const Icon(Icons.phone_outlined, color: primaryColor),
                          validator: (val) {
                            if (val == null || val.trim().length != 10) {
                              return "Enter 10-digit number";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),

                  // Age
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Formfieldtitle(title: "Age *"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          controller: _ageController,
                          isObscure: false,
                          KeyBoardType: TextInputType.number,
                          hinttext: "e.g., 38",
                          errormessage: "Enter age",
                          prefixicon: const Icon(Icons.cake_outlined, color: primaryColor),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) return "Required";
                            final parsedAge = int.tryParse(val.trim());
                            if (parsedAge == null || parsedAge < 18 || parsedAge > 100) {
                              return "Invalid age";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Section 2: Residential & Location Information
              _buildSectionTitle("Residential Location"),
              SizedBox(height: 12.h),

              Formfieldtitle(title: "Village / Town *"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _villageController,
                isObscure: false,
                hinttext: "e.g., Palus / Kundal",
                errormessage: "Please enter village or town name",
                prefixicon: const Icon(Icons.holiday_village_outlined, color: primaryColor),
              ),
              SizedBox(height: 14.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Taluka
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Formfieldtitle(title: "Taluka *"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          controller: _talukaController,
                          isObscure: false,
                          hinttext: "e.g., Palus",
                          errormessage: "Enter taluka",
                          prefixicon: const Icon(Icons.alt_route_rounded, color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),

                  // District
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Formfieldtitle(title: "District *"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          controller: _districtController,
                          isObscure: false,
                          hinttext: "e.g., Sangli",
                          errormessage: "Enter district",
                          prefixicon: const Icon(Icons.location_city_outlined, color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),

              // State
              Formfieldtitle(title: "State *"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _stateController,
                isObscure: false,
                hinttext: "e.g., Maharashtra",
                errormessage: "Please enter state",
                prefixicon: const Icon(Icons.map_outlined, color: primaryColor),
              ),
              SizedBox(height: 28.h),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 46.h,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitMember,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: _isSubmitting
                      ? SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : Text(
                    "Enroll SHG Member",
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
    );
  }
}

