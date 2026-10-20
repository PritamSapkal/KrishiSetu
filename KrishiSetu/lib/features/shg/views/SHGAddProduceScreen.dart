import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/Widgets/FormFieldTitle.dart';
import '../../../../core/Widgets/TextFormField.dart';
import '../../../core/models/ProductModel.dart';
import '../../fpo/viewmodels/ProduceListRiverpod.dart';
import '../dummydata/MockShgData.dart';
import '../dummydata/Shg_ProduceDummyList.dart';

class SHGAddProduceScreen extends ConsumerStatefulWidget {
  const SHGAddProduceScreen({super.key});

  @override
  ConsumerState<SHGAddProduceScreen> createState() => _SHGAddProduceScreenState();
}

class _SHGAddProduceScreenState extends ConsumerState<SHGAddProduceScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  // SHG Tailored Categories
  String _selectedCategory = "Flour";
  final List<String> _categories = [
    "Flour",
    "Snacks & Namkeen",
    "Papads & Crisps",
    "Raw Millet",
    "Spices & Masala",
    "Processed Foods",
  ];

  // Packaging & Measurement Units
  String _selectedUnit = "PACKS";
  final List<String> _units = [
    "PACKS",
    "KG",
    "QUINTAL",
    "BOX",
  ];

  bool _isActive = true;
  bool _isSubmitting = false;

  static const Color primaryColor = Color(0xff880D4F);
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
      id: "SHG_PRD_${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}",
      name: _nameController.text.trim(),
      category: _selectedCategory,
      description: _descriptionController.text.trim(),
      price: double.tryParse(_priceController.text.trim()) ?? 0.0,
      quantity: double.tryParse(_quantityController.text.trim()) ?? 0.0,
      unit: _selectedUnit,
      sellerId: MockShgData.mockShgAuth.user?.id ?? "6abe093fb9e86f93f1989df2",
      imageUrl: _imageUrlController.text.trim().isNotEmpty
          ? _imageUrlController.text.trim()
          : "https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=500&q=80",
      active: _isActive,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    // Insert into SHG Product list
    ref.read(ProduceListProvider.notifier).addproduct(newProduct);

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "SHG Produce listed successfully!",
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
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Add SHG Produce',
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
                "Product Specifications",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              SizedBox(height: 12.h),

              // Product Name
              Formfieldtitle(title: "Product Title *"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _nameController,
                isObscure: false,
                hinttext: "e.g., Roasted Multi-Millet Flour",
                errormessage: "Please enter product name",
                prefixicon: const Icon(Icons.bakery_dining_outlined, color: primaryColor),
              ),
              SizedBox(height: 14.h),

              // Category Dropdown
              Formfieldtitle(title: "Produce Category *"),
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

              // Quantity & Unit Selection
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Formfieldtitle(title: "Quantity In Stock *"),
                        SizedBox(height: 6.h),
                        Textformfieldwidget(
                          controller: _quantityController,
                          isObscure: false,
                          KeyBoardType: const TextInputType.numberWithOptions(decimal: true),
                          hinttext: "e.g., 150",
                          errormessage: "Enter quantity",
                          prefixicon: const Icon(Icons.inventory_2_outlined, color: primaryColor),
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

              // Price Per Unit
              Formfieldtitle(title: "Price per Unit (₹) *"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _priceController,
                isObscure: false,
                KeyBoardType: const TextInputType.numberWithOptions(decimal: true),
                hinttext: "e.g., 85.0",
                errormessage: "Enter price per unit",
                prefixicon: const Icon(Icons.currency_rupee, color: primaryColor),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return "Required";
                  final d = double.tryParse(val.trim());
                  if (d == null || d <= 0) return "Must be > 0";
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
                hinttext: "https://example.com/item.jpg",
                prefixicon: const Icon(Icons.image_outlined, color: primaryColor),
                validator: (val) => null, // Optional
              ),
              SizedBox(height: 14.h),

              // Description
              Formfieldtitle(title: "Description / Preparation Details *"),
              SizedBox(height: 6.h),
              Textformfieldwidget(
                controller: _descriptionController,
                isObscure: false,
                KeyBoardType: TextInputType.multiline,
                hinttext: "Describe ingredients, stone-ground details, or shelf life...",
                errormessage: "Please enter product description",
                prefixicon: const Icon(Icons.description_outlined, color: primaryColor),
              ),
              SizedBox(height: 16.h),

              // Active Switch Toggle
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
                              "Publish on Marketplace",
                              style: GoogleFonts.poppins(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: textDark,
                              ),
                            ),
                            Text(
                              _isActive ? "Visible for buyers to order" : "Saved as draft / hidden",
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

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 46.h,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitProduct,
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
                    "Publish SHG Produce",
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

  // --- Dropdown Helper ---
  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required IconData icon,
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
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  Icon(icon, size: 16.sp, color: primaryColor),
                  SizedBox(width: 8.w),
                  Text(
                    item,
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
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