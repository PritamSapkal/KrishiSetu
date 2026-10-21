import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/models/OrderModel.dart';
import '../viewmodels/buyer_order_riverpod.dart';
import '../viewmodels/cart_riverpod.dart';
import '../viewmodels/consumer_bottom_index_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  static const Color primaryColor = Color(0xff004D40); // Deep Emerald Teal
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
  TextEditingController(text: "Pritam Sapkal");
  final TextEditingController _phoneController =
  TextEditingController(text: "9876543210");
  final TextEditingController _addressController =
  TextEditingController(text: "Plot No. 12, APMC Market Road, Sangli");
  final TextEditingController _pincodeController =
  TextEditingController(text: "416416");

  bool _isPlacingOrder = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  void _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isPlacingOrder = true);

    await Future.delayed(const Duration(milliseconds: 700));

    final cartItems = ref.read(cartProvider);

    // Convert each cart item into a registered OrderModel
    final newOrders = cartItems.map((cartItem) {
      final p = cartItem.product;
      return OrderModel(
        id: "BYR_${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}_${cartItems.indexOf(cartItem)}",
        buyerId: "6abe08d8b9e86f93f1989df0",
        productId: p.id ?? '',
        name: p.name ?? 'Millet Produce',
        imageUrl: p.imageUrl ?? '',
        quantity: cartItem.quantity.toDouble(),
        unit: p.unit ?? 'Unit',
        pricePerUnit: p.price?.toDouble() ?? 0.0,
        totalPrice: cartItem.totalPrice,
        status: OrderStatus.PENDING, // Starts as PENDING for the seller to confirm
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }).toList();

    // 1. Add to Buyer's live orders list
    ref.read(buyerOrderListProvider.notifier).addOrders(newOrders);

    // 2. Clear Cart
    ref.read(cartProvider.notifier).clearCart();

    if (!mounted) return;

    setState(() => _isPlacingOrder = false);

    // Pop back to root dashboard and jump to Orders tab (index 2)
    Navigator.pop(context);
    ref.read(consumerBottomIndexProvider.notifier).update((state) => 2);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Order Placed Successfully! (Cash on Delivery)",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color(0xff2E7D32),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = ref.watch(cartSubtotalProvider);
    final currencyFormatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(
          "Checkout & Confirmation",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery Address Section
              _buildSectionTitle("1. Delivery Address"),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      cursorColor: Colors.black,
                      style: GoogleFonts.poppins(color: Colors.black),
                      decoration: const InputDecoration(
                          labelText: "Full Name",
                          prefixIcon: Icon(Icons.person_outline)),
                      validator: (v) => v!.isEmpty ? "Enter name" : null,
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: GoogleFonts.poppins(color: Colors.black),
                      decoration: const InputDecoration(labelText: "Mobile Number", prefixIcon: Icon(Icons.phone_outlined)),
                      validator: (v) => v!.length != 10 ? "Enter 10-digit number" : null,
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _addressController,
                      style: GoogleFonts.poppins(color: Colors.black),
                      maxLines: 2,
                      decoration: const InputDecoration(labelText: "Full Address", prefixIcon: Icon(Icons.location_on_outlined)),
                      validator: (v) => v!.isEmpty ? "Enter address" : null,
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _pincodeController,
                      style: GoogleFonts.poppins(color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Pin Code", prefixIcon: Icon(Icons.pin_drop_outlined)),
                      validator: (v) => v!.length != 6 ? "Enter 6-digit PIN" : null,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),

              // Payment Method Section
              _buildSectionTitle("2. Payment Method"),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: primaryColor, width: 1.2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.radio_button_checked, color: primaryColor, size: 20.sp),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cash on Delivery (Pay on Delivery)",
                          style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.bold, color: textDark),
                        ),
                        Text(
                          "Pay directly upon receipt of your produce",
                          style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),

              // Final Total Banner
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: const Color(0xffE0F2F1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Amount Payable:", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12.sp)),
                    Text(
                      currencyFormatter.format(subtotal),
                      style: GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: _isPlacingOrder ? null : _placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  child: _isPlacingOrder
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                    "Place Order (Confirm)",
                    style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(fontSize: 13.sp, fontWeight: FontWeight.bold, color: textDark),
    );
  }
}