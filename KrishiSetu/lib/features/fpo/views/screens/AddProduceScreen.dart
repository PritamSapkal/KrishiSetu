import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/Widgets/FormFieldTitle.dart';
import '../../../../core/Widgets/TextFormField.dart';
import '../../../../core/models/ProductModel.dart';
import '../../dummydata/MockFpoData.dart';
import '../../dummydata/ProductListingDummyData.dart';
import '../../viewmodels/ProduceListRiverpod.dart';
// For sellerId from logged-in FPO

class Addproducescreen extends ConsumerStatefulWidget {
  const Addproducescreen({super.key});

  @override
  ConsumerState<Addproducescreen> createState() => _AddproducescreenState();
}

class _AddproducescreenState extends ConsumerState<Addproducescreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  // Dropdown Selections
  String _selectedCategory = "Raw Millet";
  final List<String> _categories = [
    "Raw Millet",
    "Flour",
    "Snacks",
    "Grains",
    "Processed",
  ];

  String _selectedUnit = "KG";
  final List<String> _units = [
    "KG",
    "QUINTAL",
    "TONNE",
    "PACKS",
  ];

  bool _isActive = true;
  bool _isSubmitting = false;

  static const Color primaryBrown = Color(0xff964900);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submitProduct() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please fill in all required fields properly",
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

    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 700));

    // Check mounted before doing anything that touches UI/context after an await
    if (!mounted) return;

    final newProduct = ProductModel(
      id: "PROD_${DateTime.now().millisecondsSinceEpoch}",
      name: _nameController.text.trim(),
      category: _selectedCategory,
      description: _descriptionController.text.trim(),
      price: double.tryParse(_priceController.text.trim()) ?? 0.0,
      quantity: double.tryParse(_quantityController.text.trim()) ?? 0.0,
      unit: _selectedUnit,
      sellerId: MockFpoData.mockFpoAuth.user?.id ?? "6708d7211a9c8f2b34a09876",
      imageUrl: _imageUrlController.text.trim().isNotEmpty
          ? _imageUrlController.text.trim()
          : "https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80",
      active: _isActive,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    // 1. Dispatch update through Riverpod so all watching widgets re-render
    ref.read(ProduceListProvider.notifier).addproduct(newProduct);

    // 2. (Optional) update local dummy list reference if other non-Riverpod screens rely on it
    mockProductList.insert(0, newProduct);

    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Produce added successfully!",
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
        backgroundColor: primaryBrown,
        foregroundColor: Colors.white,
        title: Text(
          'Add Produce',
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
              // Section Header
              Text(
                "Produce Basic Details",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              SizedBox(height: 12.h),

              // Produce Name
              Formfieldtitle(title: "Produce Name *"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _nameController,
                KeyBoardType: TextInputType.name,
                isObscure: false,
                hinttext: "e.g., Organic Finger Millet (Ragi)",
                errormessage: "Please enter produce name",
                prefixicon: const Icon(Icons.eco_outlined, color: Colors.green),
              ),
              SizedBox(height: 14.h),

              // Category Selector
              Formfieldtitle(title: "Category *"),
              SizedBox(height: 6.h),
              _buildDropdown(
                value: _selectedCategory,
                items: _categories,
                icon: Icons.category_outlined,
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCategory = val);
                },
              ),
              SizedBox(height: 14.h),

              // Unit & Quantity Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quantity
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Formfieldtitle(title: "Quantity *"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          controller: _quantityController,
                          isObscure: false,
                          KeyBoardType: const TextInputType.numberWithOptions(decimal: true),
                          hinttext: "e.g., 500",
                          errormessage: "Enter quantity",
                          prefixicon: const Icon(Icons.production_quantity_limits, color: Colors.green),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Enter quantity";
                            }
                            final numVal = double.tryParse(value.trim());
                            if (numVal == null || numVal <= 0) {
                              return "Must be > 0";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),

                  // Unit Type
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Formfieldtitle(title: "Unit *"),
                        SizedBox(height: 6.h),
                        _buildDropdown(
                          value: _selectedUnit,
                          items: _units,
                          icon: Icons.scale_outlined,
                          onChanged: (val) {
                            if (val != null) setState(() => _selectedUnit = val);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),

              // Price per Unit
              Formfieldtitle(title: "Price per Unit (₹) *"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _priceController,
                isObscure: false,
                KeyBoardType: const TextInputType.numberWithOptions(decimal: true),
                hinttext: "e.g., 45.0",
                errormessage: "Enter price per unit",
                prefixicon: const Icon(Icons.currency_rupee, color: Colors.green),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter price per unit";
                  }
                  final numVal = double.tryParse(value.trim());
                  if (numVal == null || numVal <= 0) {
                    return "Must be > 0";
                  }
                  return null;
                },
              ),
              SizedBox(height: 14.h),

              // Image URL (Optional)
              Formfieldtitle(title: "Product Image URL (Optional)"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _imageUrlController,
                isObscure: false,
                KeyBoardType: TextInputType.url,
                hinttext: "https://example.com/image.jpg",
                prefixicon: const Icon(Icons.image_outlined, color: Colors.green),
                validator: (value) => null, // Optional
              ),
              SizedBox(height: 14.h),

              // Description
              Formfieldtitle(title: "Description *"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _descriptionController,
                isObscure: false,
                KeyBoardType: TextInputType.multiline,
                hinttext: "Describe crop quality, harvest grade, or packaging details...",
                errormessage: "Please enter description",
                prefixicon: const Icon(Icons.description_outlined, color: Colors.green),
              ),
              SizedBox(height: 14.h),

              // Active / Listing Status Toggle
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
                          color: _isActive ? const Color(0xff2E7D32) : Colors.grey,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Make Active on Marketplace",
                              style: GoogleFonts.poppins(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: textDark,
                              ),
                            ),
                            Text(
                              _isActive ? "Buyers can view and order immediately" : "Saved as draft / hidden",
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
                      activeColor: const Color(0xff2E7D32),
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

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 46.h,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitProduct,
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
                    "Publish Produce",
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

  // --- Dropdown Builder Helper ---
  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.grey, width: 0.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          isExpanded: true,
          dropdownColor: Colors.white,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  Icon(icon, size: 16.sp, color: Colors.green),
                  SizedBox(width: 8.w),
                  Text(
                    item,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: textDark,
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
}