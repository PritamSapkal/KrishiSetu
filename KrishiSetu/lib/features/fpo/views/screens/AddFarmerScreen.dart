import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/Widgets/FormFieldTitle.dart';
import '../../../../core/Widgets/TextFormField.dart';
import '../../models/farmer_model.dart';
import '../../viewmodels/famerlistProvider.dart';

class AddNewFarmer extends ConsumerStatefulWidget {
  const AddNewFarmer({super.key});

  @override
  ConsumerState<AddNewFarmer> createState() => _AddNewFarmerState();
}

class _AddNewFarmerState extends ConsumerState<AddNewFarmer> {
  final _formKey = GlobalKey<FormState>();

  // Personal & Location Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _districtController = TextEditingController(text: "Sangli");
  final TextEditingController _pinCodeController = TextEditingController();

  // Farm & Production Controllers
  final TextEditingController _farmSizeController = TextEditingController();
  final TextEditingController _contributionValueController = TextEditingController();

  // Units
  String _selectedFarmUnit = "Acres";
  final List<String> _farmUnits = ["Acres", "Hectares", "Guntha"];

  String _selectedContributionUnit = "Quintal";
  final List<String> _contributionUnits = ["KG", "Quintal", "Tonne"];

  // Available Crops & Selection
  final List<String> _availableCrops = [
    "Finger Millet (Ragi)",
    "Pearl Millet (Bajra)",
    "Sorghum (Jowar)",
    "Foxtail Millet",
    "Soybean",
    "Wheat",
    "Tur Dal",
  ];
  final List<String> _selectedCrops = [];

  bool _isSubmitting = false;

  static const Color primaryBrown = Color(0xff964900);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileController.dispose();
    _villageController.dispose();
    _districtController.dispose();
    _pinCodeController.dispose();
    _farmSizeController.dispose();
    _contributionValueController.dispose();
    super.dispose();
  }

  void _submitFarmer() async {
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

    if (_selectedCrops.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please select at least one primary crop",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: Colors.orange.shade800,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await Future.delayed(const Duration(milliseconds: 600));

    final newFarmer = FarmerModel(
      farmerId: "FAR_${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}",
      fullName: _fullNameController.text.trim(),
      mobileNumber: _mobileController.text.trim(),
      pinCode: _pinCodeController.text.trim(),
      village: _villageController.text.trim(),
      district: _districtController.text.trim(),
      memberSince: "${DateTime.now().year}",
      primaryCrops: List.from(_selectedCrops),
      farmSize: double.tryParse(_farmSizeController.text.trim()) ?? 0.0,
      farmSizeUnit: _selectedFarmUnit,
      currentContribution: FarmerContributionModel(
        value: double.tryParse(_contributionValueController.text.trim()) ?? 0.0,
        unit: _selectedContributionUnit,
      ),
    );

    // Appending to the base list automatically updates the filtered provider
    ref.read(farmerListProvider.notifier).update((state) => [...state, newFarmer]);

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Farmer profile enrolled successfully!",
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
        foregroundColor: Colors.white,
        backgroundColor: primaryBrown,
        elevation: 0,
        title: Text(
          'Add Farmer',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Section 1: Basic Information ---
              _buildSectionTitle("Personal Details"),
              SizedBox(height: 12.h),

              Formfieldtitle(title: "Farmer Full Name *"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _fullNameController,
                isObscure: false,
                hinttext: "e.g., Ramesh Narayan Patil",
                errormessage: "Please enter farmer's full name",
                prefixicon: const Icon(Icons.person_outline, color: Colors.green),
              ),
              SizedBox(height: 14.h),

              Formfieldtitle(title: "Mobile Number *"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _mobileController,
                isObscure: false,
                KeyBoardType: TextInputType.phone,
                hinttext: "e.g., 9822334455",
                errormessage: "Enter valid 10-digit number",
                prefixicon: const Icon(Icons.phone_outlined, color: Colors.green),
                validator: (val) {
                  if (val == null || val.trim().length != 10) {
                    return "Enter valid 10-digit mobile number";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),

              // --- Section 2: Location Information ---
              _buildSectionTitle("Village & Location"),
              SizedBox(height: 12.h),

              Formfieldtitle(title: "Village / Town *"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _villageController,
                isObscure: false,
                hinttext: "e.g., Palus / Kundal",
                errormessage: "Enter village or town name",
                prefixicon: const Icon(Icons.home_work_outlined, color: Colors.green),
              ),
              SizedBox(height: 14.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
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
                          prefixicon: const Icon(Icons.location_city_outlined, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Formfieldtitle(title: "Pin Code *"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          controller: _pinCodeController,
                          isObscure: false,
                          KeyBoardType: TextInputType.number,
                          hinttext: "e.g., 416310",
                          errormessage: "Enter PIN",
                          prefixicon: const Icon(Icons.pin_drop_outlined, color: Colors.green),
                          validator: (val) {
                            if (val == null || val.trim().length != 6) {
                              return "Invalid PIN";
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

              // --- Section 3: Farm Holding & Contribution ---
              _buildSectionTitle("Land Holding & Contribution"),
              SizedBox(height: 12.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Formfieldtitle(title: "Farm Size *"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          controller: _farmSizeController,
                          isObscure: false,
                          KeyBoardType: const TextInputType.numberWithOptions(decimal: true),
                          hinttext: "e.g., 4.5",
                          errormessage: "Enter size",
                          prefixicon: const Icon(Icons.landscape_outlined, color: Colors.green),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) return "Required";
                            final d = double.tryParse(val.trim());
                            if (d == null || d <= 0) return "Invalid";
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Formfieldtitle(title: "Unit *"),
                        SizedBox(height: 6.h),
                        _buildDropdown(
                          value: _selectedFarmUnit,
                          items: _farmUnits,
                          onChanged: (val) {
                            if (val != null) setState(() => _selectedFarmUnit = val);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Formfieldtitle(title: "Current Contribution *"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          controller: _contributionValueController,
                          isObscure: false,
                          KeyBoardType: const TextInputType.numberWithOptions(decimal: true),
                          hinttext: "e.g., 25.0",
                          errormessage: "Enter quantity",
                          prefixicon: const Icon(Icons.scale_outlined, color: Colors.green),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) return "Required";
                            final d = double.tryParse(val.trim());
                            if (d == null || d < 0) return "Invalid";
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Formfieldtitle(title: "Unit *"),
                        SizedBox(height: 6.h),
                        _buildDropdown(
                          value: _selectedContributionUnit,
                          items: _contributionUnits,
                          onChanged: (val) {
                            if (val != null) setState(() => _selectedContributionUnit = val);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // --- Section 4: Primary Crops Multi-Selection ---
              _buildSectionTitle("Primary Crops Cultivated *"),
              SizedBox(height: 4.h),
              Text(
                "Tap to select all crops produced by this member",
                style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
              ),
              SizedBox(height: 10.h),

              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: _availableCrops.map((crop) {
                  final isSelected = _selectedCrops.contains(crop);
                  return FilterChip(
                    label: Text(crop),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedCrops.add(crop);
                        } else {
                          _selectedCrops.remove(crop);
                        }
                      });
                    },
                    selectedColor: const Color(0xffFAF0E6),
                    checkmarkColor: primaryBrown,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      side: BorderSide(
                        color: isSelected ? primaryBrown : Colors.grey.shade300,
                        width: isSelected ? 1.4 : 0.8,
                      ),
                    ),
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? primaryBrown : textDark,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 28.h),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 46.h,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitFarmer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBrown,
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
                    "Enroll Farmer",
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

  // --- Helper: Section Title Header ---
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

  // --- Helper: Clean Dropdown Form Element ---
  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.grey, width: 0.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: textDark,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}