import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:krishisetu/core/constants/RollDataList.dart';

import '../../../core/Widgets/FormFieldTitle.dart';
import '../../../core/Widgets/TextFormField.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Map<String, dynamic>? _selectedRole;
  bool _obscurePassword = true;

  static const Color primaryGreen = Color(0xff1B6E2C);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff8A9099);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Green Hero Section
            _buildHeader(context),

            // Registration Form Body
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Full Name
                    Formfieldtitle(title: "Full Name"),
                    SizedBox(height: 6.h),
                    Textformfieldwidget(
                      controller: _nameController,
                      KeyBoardType: TextInputType.name,
                      isObscure: false,
                      hinttext: "Enter full name",
                      errormessage: "Please enter your full name",
                      prefixicon: Icon(
                        Icons.person_outline_rounded,
                        color: primaryGreen,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Email Address
                    Formfieldtitle(title: "Email Address"),
                    SizedBox(height: 6.h),
                    Textformfieldwidget(
                      controller: _emailController,
                      KeyBoardType: TextInputType.emailAddress,
                      isObscure: false,
                      hinttext: "Enter e-mail address",
                      prefixicon: Icon(
                        Icons.mail_outline_rounded,
                        color: primaryGreen,
                        size: 20.sp,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter email address";
                        }
                        if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value.trim())) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),

                    // Phone Number
                    Formfieldtitle(title: "Phone No"),
                    SizedBox(height: 6.h),
                    Textformfieldwidget(
                      controller: _phoneController,
                      KeyBoardType: TextInputType.phone,
                      isObscure: false,
                      hinttext: "Enter 10-digit phone number",
                      prefixicon: Icon(
                        Icons.phone_outlined,
                        color: primaryGreen,
                        size: 20.sp,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter phone number";
                        }
                        if (value.trim().length != 10) {
                          return "Enter valid 10-digit number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),

                    // Role Dropdown Selection
                    Formfieldtitle(title: "Role"),
                    SizedBox(height: 6.h),
                    _buildRoleDropdown(),
                    SizedBox(height: 16.h),

                    // Password
                    Formfieldtitle(title: "Password"),
                    SizedBox(height: 6.h),
                    Textformfieldwidget(
                      controller: _passwordController,
                      KeyBoardType: TextInputType.visiblePassword,
                      isObscure: _obscurePassword,
                      hinttext: "Create password",
                      prefixicon: Icon(
                        Icons.lock_outline_rounded,
                        color: primaryGreen,
                        size: 20.sp,
                      ),
                      suffixicon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: textMuted,
                          size: 20.sp,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter password";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 26.h),

                    // Create Account CTA Button
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_selectedRole == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Please select a role to proceed")),
                              );
                              return;
                            }
                            // Navigate directly to the corresponding registration sub-screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => _selectedRole!['screen'],
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Text(
                          "Create Account",
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Already have an account? Sign In
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: GoogleFonts.poppins(
                            fontSize: 13.sp,
                            color: const Color(0xff5A6578),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Sign In",
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: primaryGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),

                    // Terms and Privacy Note
                    Center(
                      child: Text(
                        "By signing up, you agree to KrishiSetu Terms & Privacy Policy",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          color: const Color(0xff98A2B3),
                        ),
                      ),
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

  // --- Top Header Section ---
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 44.h, 20.w, 24.h),
      decoration: const BoxDecoration(
        color: primaryGreen,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text(
              "Create Account 🌱",
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text(
              "Sign up to get started",
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: Colors.white.withOpacity(0.85),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Role Dropdown Field ---
  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<Map<String, dynamic>>(
      value: _selectedRole,
      hint: Text(
        "Select Role",
        style: GoogleFonts.poppins(
          fontSize: 13.sp,
          wordSpacing: 2.sp,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: const Color(0xff43546F),
        size: 22.sp,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: 14.w,
        ),
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: Icon(Icons.work_outline_rounded, color: primaryGreen, size: 20.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 0.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xff00D100),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 0.2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xff00D100),
            width: 1,
          ),
        ),
      ),
      items: rolesList.map((role) {
        return DropdownMenuItem<Map<String, dynamic>>(
          value: role,
          child: Row(
            children: [
              FaIcon(role['icon'], size: 14.sp, color: role['color'] as Color),
              SizedBox(width: 10.w),
              Text(
                role['title'] as String,
                style: GoogleFonts.poppins(fontSize: 13.sp, color: textDark, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          _selectedRole = val;
        });
      },
      validator: (val) => val == null ? "Please select a role" : null,
    );
  }
}