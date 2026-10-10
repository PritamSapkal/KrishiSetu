import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/Widgets/CustomeButton/GreenButton.dart';
import '../../../../core/Widgets/FormFieldTitle.dart';
import '../../../../core/Widgets/TextFormField.dart';
import '../SignInPage.dart';

class ProcessorSaveProfileScreen extends ConsumerStatefulWidget {
  const ProcessorSaveProfileScreen({super.key});

  @override
  ConsumerState<ProcessorSaveProfileScreen> createState() => _ProcessorSaveProfileScreenState();
}

class _ProcessorSaveProfileScreenState extends ConsumerState<ProcessorSaveProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers mapping to the JSON schema
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController();
  final TextEditingController _gstNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _villageOrCityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController(text: "Maharashtra");

  // Business Type Options
  String _selectedBusinessType = "Private Limited";
  final List<String> _businessTypes = [
    "Proprietorship",
    "Partnership",
    "Private Limited",
    "LLP",
    "Public Limited",
    "Other",
  ];

  // Server ProcessingActivity enum values
  final List<String> _availableActivities = [
    "CLEANING",
    "GRADING",
    "DEHULLING",
    "MILLING",
    "FLOUR_PRODUCTION",
    "PACKAGING",
    "MILLET_PRODUCT_MANUFACTURING",
    "OTHER",
  ];

  final List<String> _selectedActivities = [
    "CLEANING",
    "GRADING",
    "MILLING",
    "PACKAGING",
  ];

  static const Color primaryGreen = Color(0xff166a20);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff6C757D);

  @override
  void dispose() {
    _businessNameController.dispose();
    _registrationNumberController.dispose();
    _gstNumberController.dispose();
    _addressController.dispose();
    _villageOrCityController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _generateProcessorJson() {
    return {
      "businessName": _businessNameController.text.trim(),
      "businessRegistrationNumber": _registrationNumberController.text.trim(),
      "businessType": _selectedBusinessType,
      "processingActivities": _selectedActivities,
      "address": _addressController.text.trim(),
      "villageOrCity": _villageOrCityController.text.trim(),
      "district": _districtController.text.trim(),
      "state": _stateController.text.trim(),
      "gstNumber": _gstNumberController.text.trim().toUpperCase(),
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
          "Complete Processor Profile",
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
                    // Card 1: Enterprise & Business Registration
                    _buildCardContainer(
                      title: "Enterprise & Legal Details",
                      subtitle: "Official registration and tax identification",
                      icon: Icons.factory_outlined,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Business Name
                          Formfieldtitle(title: "Business / Enterprise Name"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _businessNameController,
                            isObscure: false,
                            errormessage: "Please enter enterprise name",
                            hinttext: "e.g. Sahyadri Agro Processing Enterprise",
                            prefixicon: const Icon(Icons.business_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 14.h),

                          // Business Type Dropdown
                          Formfieldtitle(title: "Business Type"),
                          SizedBox(height: 6.h),
                          Container(
                            height: 52.h,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey, width: 0.2),
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedBusinessType,
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_drop_down, color: primaryGreen),
                                items: _businessTypes.map((type) {
                                  return DropdownMenuItem(
                                    value: type,
                                    child: Text(
                                      type,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: textDark,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() => _selectedBusinessType = val);
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 14.h),

                          // Business Registration Number (Udyam/CIN)
                          Formfieldtitle(title: "Registration Number (Udyam / CIN)"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _registrationNumberController,
                            isObscure: false,
                            errormessage: "Please enter registration number",
                            hinttext: "e.g. UDYAM-MH-31-0012456",
                            prefixicon: const Icon(Icons.badge_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 14.h),

                          // GST Number
                          Formfieldtitle(title: "GST Number"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _gstNumberController,
                            isObscure: false,
                            errormessage: "Please enter valid GSTIN",
                            hinttext: "e.g. 27AAACS1429B1Z8",
                            prefixicon: const Icon(Icons.receipt_long_outlined, color: primaryGreen),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // Card 2: Processing Activities (Enum multi-select)
                    _buildCardContainer(
                      title: "Processing Operations",
                      subtitle: "Select all processing activities performed at your unit",
                      icon: Icons.precision_manufacturing_outlined,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: _availableActivities.map((activity) {
                              final isSelected = _selectedActivities.contains(activity);
                              // Friendly label from enum: FLOUR_PRODUCTION -> Flour Production
                              final displayName = activity
                                  .split('_')
                                  .map((word) => word.isNotEmpty
                                  ? '${word[0]}${word.substring(1).toLowerCase()}'
                                  : '')
                                  .join(' ');

                              return FilterChip(
                                label: Text(displayName),
                                labelStyle: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                  color: isSelected ? Colors.white : textDark,
                                ),
                                selected: isSelected,
                                selectedColor: primaryGreen,
                                backgroundColor: const Color(0xffF0F4F1),
                                checkmarkColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                  side: BorderSide(
                                    color: isSelected ? primaryGreen : Colors.grey.shade300,
                                    width: 0.8,
                                  ),
                                ),
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      _selectedActivities.add(activity);
                                    } else {
                                      if (_selectedActivities.length > 1) {
                                        _selectedActivities.remove(activity);
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Select at least one processing activity"),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      }
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // Card 3: Processing Unit Location
                    _buildCardContainer(
                      title: "Unit Location & Facility Address",
                      subtitle: "Factory or warehouse location for grain delivery",
                      icon: Icons.location_on_outlined,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Street / Gat / MIDC Address
                          Formfieldtitle(title: "Facility Street / Plot Address"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _addressController,
                            isObscure: false,
                            errormessage: "Please enter facility address",
                            hinttext: "e.g. Gat No. 142, MIDC Kupwad",
                            prefixicon: const Icon(Icons.home_work_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 14.h),

                          // Village or City
                          Formfieldtitle(title: "City / Village / Industrial Area"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _villageOrCityController,
                            isObscure: false,
                            errormessage: "Please enter city or village",
                            hinttext: "e.g. Sangli",
                            prefixicon: const Icon(Icons.location_city_outlined, color: primaryGreen),
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

                    // Save Processor Profile Button
                    Greenbutton(
                      btname: "Save Processor Profile",
                      btfunction: () {
                        if (_formKey.currentState!.validate()) {
                          final payload = _generateProcessorJson();
                          debugPrint("Saving Processor Profile JSON: $payload");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: primaryGreen,
                              content: Text("Processor profile saved successfully!"),
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
              Icons.precision_manufacturing_outlined,
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
                  "Set Up Processor Profile",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                ),
                Text(
                  "Register processing infrastructure, license, and unit operations",
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