import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishisetu/features/auth/views/SignInPage.dart';

import '../../../../core/Widgets/CustomeButton/GreenButton.dart';
import '../../../../core/Widgets/FormFieldTitle.dart';
import '../../../../core/Widgets/TextFormField.dart';

class FarmerSaveProfileScreen extends ConsumerStatefulWidget {
  const FarmerSaveProfileScreen({super.key});

  @override
  ConsumerState<FarmerSaveProfileScreen> createState() => _FarmerSaveProfileScreenState();
}

class _FarmerSaveProfileScreenState extends ConsumerState<FarmerSaveProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers matching the JSON schema
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _talukaController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController(text: "Maharashtra");
  final TextEditingController _farmSizeController = TextEditingController();

  // Unit and Millets selection state
  String _selectedFarmUnit = "ACRE";
  final List<String> _farmUnits = ["ACRE", "GUNTHA", "HECTARE"];

  final List<String> _availableMillets = [
    "JOWAR",
    "BAJRA",
    "RAGI",
    "FOXTAIL",
    "PROSO",
    "BARNYARD",
    "KODO",
    "LITTLE MILLET",
  ];
  final List<String> _selectedMilletCrops = ["JOWAR"];

  static const Color primaryGreen = Color(0xff166a20);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff6C757D);

  @override
  void dispose() {
    _villageController.dispose();
    _talukaController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _farmSizeController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _generateProfileJson() {
    return {
      "village": _villageController.text.trim(),
      "taluka": _talukaController.text.trim(),
      "district": _districtController.text.trim(),
      "state": _stateController.text.trim(),
      "farmSize": _farmSizeController.text.trim(),
      "farmSizeUnit": _selectedFarmUnit,
      "milletCrops": _selectedMilletCrops,
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
          "Complete Farmer Profile",
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
            _buildHeroHeader(),

            // Form Content inside elevated cards
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Card 1: Farm Land & Size
                    _buildCardContainer(
                      title: "Farm Land & Scale",
                      subtitle: "Enter your cultivable land details",
                      icon: Icons.landscape_outlined,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Formfieldtitle(title: "Farm Size & Measurement"),
                          SizedBox(height: 6.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Farm Size Input Field
                              Expanded(
                                flex: 3,
                                child: Textformfieldwidget(
                                  controller: _farmSizeController,
                                  KeyBoardType: const TextInputType.numberWithOptions(decimal: true),
                                  isObscure: false,
                                  errormessage: "Enter farm size",
                                  hinttext: "e.g. 2.5",
                                  prefixicon: const Icon(Icons.square_foot, color: primaryGreen),
                                ),
                              ),
                              SizedBox(width: 10.w),

                              // Measurement Unit Selector Dropdown
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 52.h,
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.grey.shade400, width: 0.5),
                                    color: Colors.white,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedFarmUnit,
                                      isExpanded: true,
                                      icon: const Icon(Icons.arrow_drop_down, color: primaryGreen),
                                      items: _farmUnits.map((unit) {
                                        return DropdownMenuItem(
                                          value: unit,
                                          child: Text(
                                            unit,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: textDark,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        if (val != null) {
                                          setState(() => _selectedFarmUnit = val);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // Card 2: Cultivated Millet Crops (Multi-select)
                    _buildCardContainer(
                      title: "Millet Crops Cultivated",
                      subtitle: "Select all millets you currently grow or harvest",
                      icon: Icons.grass_outlined,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: _availableMillets.map((crop) {
                              final isSelected = _selectedMilletCrops.contains(crop);
                              return FilterChip(
                                label: Text(crop),
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
                                      _selectedMilletCrops.add(crop);
                                    } else {
                                      if (_selectedMilletCrops.length > 1) {
                                        _selectedMilletCrops.remove(crop);
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar;
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Select at least one crop",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                            duration: Duration(seconds: 1),
                                            backgroundColor: primaryGreen,
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

                    // Card 3: Location Details (Village, Taluka, District, State)
                    _buildCardContainer(
                      title: "Farm Location & Address",
                      subtitle: "Helps buyers and FPOs locate your farm",
                      icon: Icons.pin_drop_outlined,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Village
                          Formfieldtitle(title: "Village"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _villageController,
                            isObscure: false,
                            errormessage: "Please enter your village",
                            hinttext: "e.g. Padmale / Sangli",
                            prefixicon: const Icon(Icons.home_work_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 12.h),

                          // Taluka
                          Formfieldtitle(title: "Taluka"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _talukaController,
                            isObscure: false,
                            errormessage: "Please enter your taluka",
                            hinttext: "e.g. Miraj",
                            prefixicon: const Icon(Icons.near_me_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 12.h),

                          // District
                          Formfieldtitle(title: "District"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _districtController,
                            isObscure: false,
                            errormessage: "Please enter your district",
                            hinttext: "e.g. Sangli",
                            prefixicon: const Icon(Icons.location_city_outlined, color: primaryGreen),
                          ),
                          SizedBox(height: 12.h),

                          // State
                          Formfieldtitle(title: "State"),
                          SizedBox(height: 6.h),
                          Textformfieldwidget(
                            controller: _stateController,
                            isObscure: false,
                            errormessage: "Please enter state",
                            hinttext: "e.g. Maharashtra",
                            prefixicon: const Icon(Icons.map_outlined, color: primaryGreen),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Submit CTA Button
                    Greenbutton(
                      btname: "Save Farmer Profile",
                      btfunction: () {
                        if (_formKey.currentState!.validate()) {
                          final payload = _generateProfileJson();
                          debugPrint("Saving Farmer Profile JSON: $payload");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: primaryGreen,
                              content: Text("Farmer profile details saved successfully!"),
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

  // --- Top Banner Header ---
  Widget _buildHeroHeader() {
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
              Icons.badge_outlined,
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
                  "Set Up Farm Profile",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                ),
                Text(
                  "Add your farm size, crops, and location to connect with buyers",
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

  // --- Modern Section Card Container ---
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