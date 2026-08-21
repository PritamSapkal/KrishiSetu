import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../Data/FPO_Dummy_Data/Order_dummy_data.dart';
import '../../../Model/FarmerModel/OrderModel.dart';

class Orderdetailscreen extends StatelessWidget {
  const Orderdetailscreen({required this.index, super.key});
  final int index;

  static const Color primaryBrown = Color(0xff964900);
  static const Color accentOrange = Color(0xffE07525);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);
  static const Color cardSubBg = Color(0xffF4F5F8);

  @override
  Widget build(BuildContext context) {
    final OrderModel order = orderslist[index];

    final currencyFormatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    // Calculate subtotal and tax estimates based on total amount
    final double subtotal = order.totalAmount / 1.05;
    final double taxes = order.totalAmount - subtotal;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: primaryBrown,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Order Details",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        color: Colors.white,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.download_outlined, color: Colors.white),
          label: Text(
            "Download Invoice",
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: accentOrange,
            elevation: 0,
            minimumSize: Size(double.infinity, 46.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Column(
          children: [
            // Status & Payment Tag Card
            _buildStatusCard(order),
            SizedBox(height: 12.h),

            // Order Information Card
            _buildOrderInfoCard(order),
            SizedBox(height: 12.h),

            // Product Details Card
            _buildProductDetailsCard(order),
            SizedBox(height: 12.h),

            // Buyer Information Card
            _buildBuyerInfoCard(order),
            SizedBox(height: 12.h),

            // Payment Summary Card
            _buildPaymentSummaryCard(order, subtotal, taxes, currencyFormatter),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  // --- 1. Status & Payment Card ---
  Widget _buildStatusCard(OrderModel order) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "STATUS",
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: textMuted,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xff2E7D32), size: 16),
              SizedBox(width: 6.w),
              Text(
                order.status,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            "PAYMENT",
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: textMuted,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: const Color(0xffE2EAF8),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              order.paymentStatus == "Paid" ? "Paid in full" : order.paymentStatus,
              style: GoogleFonts.poppins(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xff3B5998),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 2. Order Information Card ---
  Widget _buildOrderInfoCard(OrderModel order) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Information",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: textDark,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order ID", style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted)),
                  Text(
                    "#${order.orderId}",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: textDark,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order Date", style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted)),
                  Text(
                    order.orderDate,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: textDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Due Date", style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted)),
              Text(
                order.dueDate,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: textDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 3. Product Details Card ---
  Widget _buildProductDetailsCard(OrderModel order) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product Details",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: textDark,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Image.asset(
                  order.product.image,
                  width: 58.r,
                  height: 58.r,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 58.r,
                    height: 58.r,
                    color: const Color(0xffECEFEF),
                    child: const Icon(Icons.eco, color: primaryBrown),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.product.name,
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    Text(
                      order.product.grade,
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        color: textMuted,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: cardSubBg,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "Qty: ${order.quantity} ${order.quantityUnit}",
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: textDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 4. Buyer Information Card ---
  Widget _buildBuyerInfoCard(OrderModel order) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Buyer Information",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: textDark,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: accentOrange,
                child: Text(
                  order.buyer.name.isNotEmpty ? order.buyer.name[0] : "B",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.buyer.name,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: textDark,
                      ),
                    ),
                    Text(
                      "Verified Corporate Buyer",
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        color: textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 5. Payment Summary Card ---
  Widget _buildPaymentSummaryCard(
      OrderModel order,
      double subtotal,
      double taxes,
      NumberFormat formatter,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Summary",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: textDark,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal (${order.quantity} ${order.quantityUnit})",
                style: GoogleFonts.poppins(fontSize: 11.sp, color: textMuted),
              ),
              Text(
                formatter.format(subtotal),
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Taxes & Fees (GST 5%)",
                style: GoogleFonts.poppins(fontSize: 11.sp, color: textMuted),
              ),
              Text(
                formatter.format(taxes),
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: textDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}