import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/models/OrderModel.dart';
import '../viewmodels/ProcessorOrderListRiverpod.dart';

class ProcessOrderManagescreen extends ConsumerWidget {
  const ProcessOrderManagescreen({required this.orderid, super.key});
  final String orderid;

  static const Color primaryColor = Color(0xff4A148C);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);
  static const Color cardSubBg = Color(0xffF3E5F5);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<OrderModel> orders = ref.watch(ProcessororderlistProvider);

    final OrderModel? order = orders.cast<OrderModel?>().firstWhere(
          (o) => o?.id == orderid,
      orElse: () => null,
    );

    final currencyFormatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    if (order == null) {
      return Scaffold(
        backgroundColor: scaffoldBg,
        appBar: AppBar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          title: Text(
            "Order Not Found",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ),
        body: Center(
          child: Text(
            "Order #$orderid not found.",
            style: GoogleFonts.poppins(color: textMuted, fontSize: 13.sp),
          ),
        ),
      );
    }

    final double subtotal = order.totalPrice / 1.05;
    final double taxes = order.totalPrice - subtotal;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Manage Order",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(context, ref, order),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Column(
          children: [
            // 1. Current Status & Transition Banner
            _buildStatusCard(order),
            SizedBox(height: 12.h),

            // 2. Order Metadata Card
            _buildOrderInfoCard(order),
            SizedBox(height: 12.h),

            // 3. Ordered Produce / Item Specs
            _buildProductDetailsCard(order),
            SizedBox(height: 12.h),

            // 4. Buyer Reference Card
            _buildBuyerInfoCard(order),
            SizedBox(height: 12.h),

            // 5. Commercial Invoicing Breakdown
            _buildPaymentSummaryCard(order, subtotal, taxes, currencyFormatter),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  // --- 1. Current Status Card ---
  Widget _buildStatusCard(OrderModel order) {
    Color statusColor;
    IconData statusIcon;

    switch (order.status) {
      case OrderStatus.PENDING:
        statusColor = const Color(0xffB76E00);
        statusIcon = Icons.access_time_rounded;
        break;
      case OrderStatus.CONFIRMED:
        statusColor = const Color(0xff1565C0);
        statusIcon = Icons.check_circle_outline;
        break;
      case OrderStatus.PROCESSING:
        statusColor = primaryColor;
        statusIcon = Icons.precision_manufacturing_outlined;
        break;
      case OrderStatus.SHIPPED:
        statusColor = const Color(0xff283593);
        statusIcon = Icons.local_shipping_outlined;
        break;
      case OrderStatus.DELIVERED:
        statusColor = const Color(0xff2E7D32);
        statusIcon = Icons.task_alt_rounded;
        break;
      case OrderStatus.CANCELLED:
        statusColor = const Color(0xffC62828);
        statusIcon = Icons.cancel_outlined;
        break;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 0.5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "CURRENT ORDER STATUS",
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: textMuted,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(statusIcon, color: statusColor, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                order.status.name,
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  order.status == OrderStatus.DELIVERED || order.status == OrderStatus.CANCELLED
                      ? "Completed"
                      : "In Progress",
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 2. Order Information Card ---
  Widget _buildOrderInfoCard(OrderModel order) {
    final formattedCreated = DateFormat('dd MMM yyyy, hh:mm a').format(order.createdAt);
    final formattedUpdated = DateFormat('dd MMM yyyy, hh:mm a').format(order.updatedAt);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 0.5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Information",
            style: GoogleFonts.poppins(fontSize: 13.sp, fontWeight: FontWeight.w700, color: textDark),
          ),
          SizedBox(height: 10.h),
          _buildInfoRow("Order ID", "#${order.id}"),
          const Divider(height: 16, thickness: 0.6),
          _buildInfoRow("Received On", formattedCreated),
          const Divider(height: 16, thickness: 0.6),
          _buildInfoRow("Last Status Update", formattedUpdated),
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
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 0.5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ordered Processing Batch",
            style: GoogleFonts.poppins(fontSize: 13.sp, fontWeight: FontWeight.w700, color: textDark),
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  order.imageUrl,
                  width: 60.r,
                  height: 60.r,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60.r,
                    height: 60.r,
                    color: const Color(0xffECEFEF),
                    child: const Icon(Icons.precision_manufacturing_outlined, color: primaryColor),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.name,
                      style: GoogleFonts.poppins(fontSize: 13.sp, fontWeight: FontWeight.bold, color: textDark),
                    ),
                    Text(
                      "SKU Ref: #${order.productId}",
                      style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: cardSubBg,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "Batch: ${order.quantity} ${order.unit} @ ₹${order.pricePerUnit.toStringAsFixed(0)}/${order.unit}",
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
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

  // --- 4. Buyer Reference Card ---
  Widget _buildBuyerInfoCard(OrderModel order) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 0.5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Buyer Details",
            style: GoogleFonts.poppins(fontSize: 13.sp, fontWeight: FontWeight.w700, color: textDark),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: primaryColor.withOpacity(0.12),
                child: Text(
                  "B",
                  style: GoogleFonts.poppins(
                    color: primaryColor,
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
                      "Buyer ID: #${order.buyerId}",
                      style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w600, color: textDark),
                    ),
                    Text(
                      "Institutional Agro Trader / Buyer",
                      style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
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

  // --- 5. Commercial Breakdown ---
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
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 0.5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Commercial Settlement",
            style: GoogleFonts.poppins(fontSize: 13.sp, fontWeight: FontWeight.w700, color: textDark),
          ),
          SizedBox(height: 10.h),
          _buildInfoRow("Subtotal (${order.quantity} ${order.unit})", formatter.format(subtotal)),
          SizedBox(height: 6.h),
          _buildInfoRow("GST (5%)", formatter.format(taxes)),
          const Divider(height: 18, thickness: 0.6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Order Value",
                style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.bold, color: textDark),
              ),
              Text(
                formatter.format(order.totalPrice),
                style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.bold, color: primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 6. Bottom Action Bar (Update Status Trigger) ---
  Widget _buildBottomActionBar(BuildContext context, WidgetRef ref, OrderModel order) {
    final bool isCompleted =
        order.status == OrderStatus.DELIVERED || order.status == OrderStatus.CANCELLED;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 46.h,
        child: ElevatedButton.icon(
          onPressed: isCompleted
              ? null
              : () => _showStatusUpdateBottomSheet(context, ref, order),
          icon: Icon(
            isCompleted ? Icons.lock_outline : Icons.edit_note_rounded,
            color: Colors.white,
            size: 20.sp,
          ),
          label: Text(
            isCompleted ? "Order Finalized" : "Update Order Status",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      ),
    );
  }

  // --- Bottom Sheet Modal for Status Transition ---
  void _showStatusUpdateBottomSheet(BuildContext context, WidgetRef ref, OrderModel order) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Update Processing Status",
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(sheetContext),
                    ),
                  ],
                ),
                Text(
                  "Select the current operational state for #${order.id.substring(order.id.length - 8)}",
                  style: GoogleFonts.poppins(fontSize: 11.sp, color: textMuted),
                ),
                SizedBox(height: 14.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 10.h,
                  children: OrderStatus.values.map((status) {
                    final bool isCurrent = order.status == status;
                    return ChoiceChip(
                      label: Text(status.name),
                      selected: isCurrent,
                      selectedColor: primaryColor,
                      backgroundColor: const Color(0xffF0F0F0),
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                        color: isCurrent ? Colors.white : textDark,
                      ),
                      onSelected: (selected) {
                        if (selected && !isCurrent) {
                          // Update Riverpod State
                          ref
                              .read(ProcessororderlistProvider.notifier)
                              .updateOrderStatus(order.id, status);

                          Navigator.pop(sheetContext);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Order status updated to ${status.name}!",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                              backgroundColor: const Color(0xff2E7D32),
                            ),
                          );
                        }
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- Helper ---
  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 11.sp, color: textMuted)),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 11.sp, fontWeight: FontWeight.w600, color: textDark),
        ),
      ],
    );
  }
}