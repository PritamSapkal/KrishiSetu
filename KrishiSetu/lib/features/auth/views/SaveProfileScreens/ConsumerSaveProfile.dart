import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/Widgets/CustomeButton/GreenButton.dart';
import '../../../../core/Widgets/FormFieldTitle.dart';
import '../../../../core/Widgets/TextFormField.dart';

class ConsumerSaveProfileScreen extends ConsumerStatefulWidget {
  const ConsumerSaveProfileScreen({super.key});

  @override
  ConsumerState<ConsumerSaveProfileScreen> createState() => _ConsumerSaveProfileScreenState();
}

class _ConsumerSaveProfileScreenState extends ConsumerState<ConsumerSaveProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers matching the JSON keys
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController(text: "Maharashtra");
  final TextEditingController _pinCodeController = TextEditingController();

  static const Color primaryGreen = Color(0xff166a20);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff6C757D);

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _generateConsumerJson() {
    return {
      "address": _addressController.text.trim(),
      "city": _cityController.text.trim(),
      "district": _districtController.text.trim(),
      "state": _stateController.text.trim(),
      "pinCode": _pinCodeController.text.trim(),
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
          "Complete Delivery Profile",
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
            // Top Green Hero Banner
            _buildHeroBanner(),

            // Form Content inside Card Container
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Primary Delivery Location Card
                    _buildCardContainer(
                      title: "Delivery & Billing Address",
                      subtitle: "Used for fresh millet & farm product door delivery",
                      icon: Icons.local_shipping_outlined,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Street / Flat / Plot Address
                          Formfieldtitle(title: "Street Address / House No."),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _addressController,
                            isObscure: false,
                            errormessage: "Please enter your address",
                            hinttext: "e.g. Plot No. 24, Shivaji Nagar",
                            prefixicon: const Icon(Icons.home_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 14.h),

                          // City and PIN Code Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // City
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Formfieldtitle(title: "City / Town"),
                                    SizedBox(height: 6.h),
                                    Textformfieldwidget(
                                      controller: _cityController,
                                      isObscure: false,
                                      errormessage: "Enter city",
                                      hinttext: "e.g. Sangli",
                                      prefixicon: const Icon(Icons.location_city_outlined, color: primaryGreen),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.w),

                              // PIN Code
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Formfieldtitle(title: "PIN Code"),
                                    SizedBox(height: 6.h),
                                    Textformfieldwidget(
                                      controller: _pinCodeController,
                                      KeyBoardType: TextInputType.number,
                                      isObscure: false,
                                      hinttext: "416416",
                                      prefixicon: const Icon(Icons.pin_outlined, color: primaryGreen),
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return "Enter PIN";
                                        }
                                        if (value.trim().length != 6) {
                                          return "6 digits";
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                            prefixicon: const Icon(Icons.map_outlined, color: primaryGreen),
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
                      btname: "Save Consumer Profile",
                      btfunction: () {
                        if (_formKey.currentState!.validate()) {
                          final payload = _generateConsumerJson();
                          debugPrint("Saving Consumer Profile JSON: $payload");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: primaryGreen,
                              content: Text("Consumer profile saved successfully!"),
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
              Icons.shopping_basket_outlined,
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
                  "Consumer Delivery Details",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                ),
                Text(
                  "Set your default address for fast farm-to-table delivery",
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

  // --- Reusable Section Card ---
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