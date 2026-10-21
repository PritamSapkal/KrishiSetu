import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../viewmodels/cart_riverpod.dart';
import '../viewmodels/consumer_bottom_index_provider.dart';
import 'CheckoutScreen.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  static const Color primaryColor = Color(0xff004D40); // Deep Emerald Teal
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);
  static const Color cardSubBg = Color(0xffE0F2F1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final subtotal = ref.watch(cartSubtotalProvider);
    const double deliveryFee = 0.0; // Free delivery threshold
    final double grandTotal = subtotal + deliveryFee;

    final currencyFormatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    if (cartItems.isEmpty) {
      return Scaffold(
        backgroundColor: scaffoldBg,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_bag_outlined, size: 64.sp, color: Colors.grey.shade400),
              SizedBox(height: 12.h),
              Text(
                "Your Cart is Empty",
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "Explore fresh millets, flours & snacks from our producers.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 11.sp, color: textMuted),
              ),
              SizedBox(height: 18.h),
              ElevatedButton(
                onPressed: () {
                  // Switch to Marketplace tab
                  ref.read(consumerBottomIndexProvider.notifier).update((state) => 0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                ),
                child: Text(
                  "Browse Marketplace",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Column(
          children: [
            // List of Cart Items
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cartItems.length,
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return _buildCartItemTile(item, ref);
              },
            ),
            SizedBox(height: 16.h),

            // Order Price Breakdown Card
            _buildBillSummaryCard(subtotal, deliveryFee, grandTotal, currencyFormatter),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Payable", style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted)),
                Text(
                  currencyFormatter.format(grandTotal),
                  style: GoogleFonts.poppins(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              child: Text(
                "Proceed to Checkout",
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Cart Item Component ---
  Widget _buildCartItemTile(dynamic item, WidgetRef ref) {
    final product = item.product;

    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 0.5)
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              product.imageUrl ?? '',
              width: 55.r,
              height: 55.r,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 55.r,
                height: 55.r,
                color: const Color(0xffECEFEF),
                child: const Icon(Icons.eco_outlined, color: primaryColor),
              ),
            ),
          ),
          SizedBox(width: 10.w),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? 'Item',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                Text(
                  "₹${product.price?.toStringAsFixed(0) ?? '0'} per ${product.unit ?? 'Unit'}",
                  style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Total: ₹${item.totalPrice.toStringAsFixed(0)}",
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Quantity Stepper & Delete
          Row(
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  item.quantity == 1 ? Icons.delete_outline : Icons.remove_circle_outline,
                  size: 18.sp,
                  color: item.quantity == 1 ? Colors.red.shade600 : primaryColor,
                ),
                onPressed: () {
                  ref.read(cartProvider.notifier).decrementQuantity(product.id ?? '');
                },
              ),
              Text(
                "${item.quantity}",
                style: GoogleFonts.poppins(fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(Icons.add_circle_outline, size: 18.sp, color: primaryColor),
                onPressed: () {
                  ref.read(cartProvider.notifier).incrementQuantity(product.id ?? '');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Bill Breakdown Card ---
  Widget _buildBillSummaryCard(
      double subtotal,
      double deliveryFee,
      double grandTotal,
      NumberFormat formatter,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 0.5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "PRICE DETAILS",
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: textMuted,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 10.h),
          _buildBillRow("Subtotal", formatter.format(subtotal)),
          SizedBox(height: 6.h),
          _buildBillRow("Delivery Charges", "FREE"),
          const Divider(height: 18, thickness: 0.6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Grand Total",
                style: GoogleFonts.poppins(fontSize: 13.sp, fontWeight: FontWeight.bold, color: textDark),
              ),
              Text(
                formatter.format(grandTotal),
                style: GoogleFonts.poppins(fontSize: 15.sp, fontWeight: FontWeight.bold, color: primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 11.sp, color: textMuted)),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 11.sp, fontWeight: FontWeight.w600, color: textDark),
        ),
      ],
    );
  }
}