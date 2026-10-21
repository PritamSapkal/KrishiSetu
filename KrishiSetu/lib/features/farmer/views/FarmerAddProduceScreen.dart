import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/Widgets/FormFieldTitle.dart';
import '../../../../core/Widgets/TextFormField.dart';
import '../../../../core/models/ProductModel.dart';
import '../dummydata/mock_farmer_data.dart';
import '../models/millet_type.dart';
import '../viewmodels/FarmerProductListRiverpod.dart';

class FarmerAddProduceScreen extends ConsumerStatefulWidget {
  const FarmerAddProduceScreen({super.key});

  @override
  ConsumerState<FarmerAddProduceScreen> createState() =>
      _FarmerAddProduceScreenState();
}

class _FarmerAddProduceScreenState extends ConsumerState<FarmerAddProduceScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController _customTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  // Millet Selection Enum
  MilletType _selectedMillet = MilletType.JOWAR;

  // Farm Units
  String _selectedUnit = "QUINTAL";
  final List<String> _units = [
    "QUINTAL",
    "KG",
    "TONNE",
    "BAGS",
  ];

  bool _isActive = true;
  bool _isSubmitting = false;

  static const Color primaryColor = Color(0xff2E7D32);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);

  @override
  void initState() {
    super.initState();
    _customTitleController.text = _selectedMillet.shortName;
  }

  @override
  void dispose() {
    _customTitleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submitCropProduce() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please complete all required fields properly",
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

    // Simulate creation delay
    await Future.delayed(const Duration(milliseconds: 600));

    final newProduct = ProductModel(
      id: "FAR_PRD_${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}",
      name: _customTitleController.text.trim().isNotEmpty
          ? _customTitleController.text.trim()
          : _selectedMillet.shortName,
      category: "Raw Millet",
      description: _descriptionController.text.trim(),
      price: double.tryParse(_priceController.text.trim()) ?? 0.0,
      quantity: double.tryParse(_quantityController.text.trim()) ?? 0.0,
      unit: _selectedUnit,
      sellerId: MockFarmerData.mockFarmerAuth.user?.id ?? "6abe08d8b9e86f93f1989df0",
      imageUrl: _imageUrlController.text.trim().isNotEmpty
          ? _imageUrlController.text.trim()
          : "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?auto=format&fit=crop&w=500&q=80",
      active: _isActive,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    // Add to Riverpod State
    ref.read(FarmerProductListProvider.notifier).addProduct(newProduct);

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Harvest produce listed successfully!",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Sell Produce',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
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
              Text(
                "Crop Harvest Details",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              SizedBox(height: 12.h),

              // 1. Millet Crop Selector (Using MilletType Enum)
              Formfieldtitle(title: "Select Millet Variety *"),
              SizedBox(height: 6.h),
              _buildMilletDropdown(),
              SizedBox(height: 14.h),

              // 2. Custom Title / Variety Name
              Formfieldtitle(title: "Display Title / Crop Name *"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _customTitleController,
                isObscure: false,
                hinttext: "e.g., Raw Maldandi Jowar",
                errormessage: "Please enter crop title",
                prefixicon: const Icon(
                  Icons.eco_outlined,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 14.h),

              // 3. Harvest Quantity & Unit Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Formfieldtitle(title: "Available Quantity *"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          controller: _quantityController,
                          isObscure: false,
                          KeyBoardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          hinttext: "e.g., 25.0",
                          errormessage: "Enter quantity",
                          prefixicon: const Icon(
                            Icons.grain_outlined,
                            color: primaryColor,
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) return "Required";
                            final d = double.tryParse(val.trim());
                            if (d == null || d <= 0) return "Must be > 0";
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
                        _buildUnitDropdown(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),

              // 4. Expected Farm-Gate Price Per Unit
              Formfieldtitle(title: "Farm-Gate Rate per Unit (₹) *"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _priceController,
                isObscure: false,
                KeyBoardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                hinttext: "e.g., 3400.0",
                errormessage: "Enter expected rate",
                prefixicon: const Icon(Icons.currency_rupee, color: primaryColor),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return "Required";
                  final d = double.tryParse(val.trim());
                  if (d == null || d <= 0) return "Must be > 0";
                  return null;
                },
              ),
              SizedBox(height: 14.h),

              // 5. Image URL (Optional)
              Formfieldtitle(title: "Crop Photo URL (Optional)"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _imageUrlController,
                isObscure: false,
                KeyBoardType: TextInputType.url,
                hinttext: "https://example.com/crop.jpg",
                prefixicon: const Icon(Icons.image_outlined, color: primaryColor),
                validator: (val) => null,
              ),
              SizedBox(height: 14.h),

              // 6. Harvest Notes / Quality Description
              Formfieldtitle(title: "Harvest & Quality Details *"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _descriptionController,
                isObscure: false,
                KeyBoardType: TextInputType.multiline,
                hinttext:
                "State moisture condition, threshing grade, organic/chemical-free status...",
                errormessage: "Please enter harvest description",
                prefixicon: const Icon(Icons.description_outlined, color: primaryColor),
              ),
              SizedBox(height: 16.h),

              // 7. Active / Visibility Toggle
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300, width: 0.8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _isActive ? Icons.visibility : Icons.visibility_off,
                          color: _isActive ? primaryColor : Colors.grey,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Publish for Sourcing",
                              style: GoogleFonts.poppins(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: textDark,
                              ),
                            ),
                            Text(
                              _isActive
                                  ? "Visible to FPOs, Processors & Buyers"
                                  : "Saved as draft / unlisted",
                              style: GoogleFonts.poppins(
                                fontSize: 9.sp,
                                color: textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Switch(
                      value: _isActive,
                      activeColor: primaryColor,
                      onChanged: (val) {
                        setState(() {
                          _isActive = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // 8. Submit Button
              SizedBox(
                width: double.infinity,
                height: 46.h,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitCropProduce,
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
                    "List Harvest Produce",
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

  // --- Millet Type Dropdown Builder ---
  Widget _buildMilletDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.grey, width: 0.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<MilletType>(
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          value: _selectedMillet,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          onChanged: (val) {
            if (val != null) {
              setState(() {
                _selectedMillet = val;
                // Pre-fill crop name with standard short name
                _customTitleController.text = val.shortName;
              });
            }
          },
          items: MilletType.values.map((millet) {
            return DropdownMenuItem<MilletType>(
              value: millet,
              child: Row(
                children: [
                  Icon(Icons.grass_outlined, size: 16.sp, color: primaryColor),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      millet.displayName,
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: textDark,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // --- Unit Dropdown Builder ---
  Widget _buildUnitDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.grey, width: 0.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          value: _selectedUnit,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          onChanged: (val) {
            if (val != null) setState(() => _selectedUnit = val);
          },
          items: _units.map((item) {
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