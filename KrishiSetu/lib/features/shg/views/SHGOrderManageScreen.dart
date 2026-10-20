import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/models/OrderModel.dart';
import '../viewmodels/SHGOrderListRiverpod.dart';

class SHGOrderManageScreen extends ConsumerStatefulWidget {
  final String orderId;

  const SHGOrderManageScreen({required this.orderId, super.key});

  static const Color primaryColor = Color(0xff880D4F);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);
  static const Color cardSubBg = Color(0xffFAF0E6);

  @override
  ConsumerState<SHGOrderManageScreen> createState() =>
      _SHGOrderManageScreenState();
}

class _SHGOrderManageScreenState extends ConsumerState<SHGOrderManageScreen> {
  @override
  Widget build(BuildContext context) {
    // Look up the order live from ShgorderlistProvider
    final List<OrderModel> orders = ref.watch(ShgorderlistProvider);

    final OrderModel? order = orders.cast<OrderModel?>().firstWhere(
          (o) => o?.id == widget.orderId,
      orElse: () => null,
    );

    final currencyFormatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    if (order == null) {
      return Scaffold(
        backgroundColor: SHGOrderManageScreen.scaffoldBg,
        appBar: AppBar(
          backgroundColor: SHGOrderManageScreen.primaryColor,
          foregroundColor: Colors.white,
          title: Text(
            "Order Not Found",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ),
        body: Center(
          child: Text(
            "Order #${widget.orderId} could not be found.",
            style: GoogleFonts.poppins(
                color: SHGOrderManageScreen.textMuted, fontSize: 13.sp),
          ),
        ),
      );
    }

    // Calculated breakdown (GST 5%)
    final double subtotal = order.totalPrice / 1.05;
    final double taxes = order.totalPrice - subtotal;

    return Scaffold(
      backgroundColor: SHGOrderManageScreen.scaffoldBg,
      appBar: AppBar(
        backgroundColor: SHGOrderManageScreen.primaryColor,
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
      bottomNavigationBar: _buildBottomActionBar(order),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Column(
          children: [
            // 1. Order Status Card
            _buildStatusCard(order),
            SizedBox(height: 12.h),

            // 2. Order Information (IDs & Timestamps)
            _buildOrderInfoCard(order),
            SizedBox(height: 12.h),

            // 3. Product & Packaging Details
            _buildProductDetailsCard(order),
            SizedBox(height: 12.h),

            // 4. Buyer Reference Card
            _buildBuyerInfoCard(order),
            SizedBox(height: 12.h),

            // 5. Payment & Invoicing Breakdown
            _buildPaymentSummaryCard(order, subtotal, taxes, currencyFormatter),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  // --- 1. Status Card ---
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
        statusColor = const Color(0xff7B1FA2);
        statusIcon = Icons.inventory_2_outlined;
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
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 0.5,
          )
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
              color: SHGOrderManageScreen.textMuted,
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
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  order.status == OrderStatus.DELIVERED ||
                      order.status == OrderStatus.CANCELLED
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
    final formattedCreated =
    DateFormat('dd MMM yyyy, hh:mm a').format(order.createdAt);
    final formattedUpdated =
    DateFormat('dd MMM yyyy, hh:mm a').format(order.updatedAt);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 0.5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Information",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: SHGOrderManageScreen.textDark,
            ),
          ),
          SizedBox(height: 10.h),
          _buildInfoRow("Order ID", "#${order.id}"),
          const Divider(height: 16, thickness: 0.6),
          _buildInfoRow("Placed On", formattedCreated),
          const Divider(height: 16, thickness: 0.6),
          _buildInfoRow("Last Updated", formattedUpdated),
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
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 0.5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ordered Product",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: SHGOrderManageScreen.textDark,
            ),
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
                    child: const Icon(Icons.bakery_dining_outlined,
                        color: SHGOrderManageScreen.primaryColor),
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
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: SHGOrderManageScreen.textDark,
                      ),
                    ),
                    Text(
                      "SKU / Item ID: #${order.productId}",
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        color: SHGOrderManageScreen.textMuted,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: SHGOrderManageScreen.cardSubBg,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "Qty: ${order.quantity} ${order.unit} @ ₹${order.pricePerUnit.toStringAsFixed(0)}/${order.unit}",
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff8D4F1E),
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
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 0.5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Buyer Reference",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: SHGOrderManageScreen.textDark,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor:
                SHGOrderManageScreen.primaryColor.withOpacity(0.12),
                child: Text(
                  "B",
                  style: GoogleFonts.poppins(
                    color: SHGOrderManageScreen.primaryColor,
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
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: SHGOrderManageScreen.textDark,
                      ),
                    ),
                    Text(
                      "Marketplace Verified Buyer",
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        color: SHGOrderManageScreen.textMuted,
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
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 0.5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Breakdown",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: SHGOrderManageScreen.textDark,
            ),
          ),
          SizedBox(height: 12.h),
          _buildAmountRow(
              "Subtotal (${order.quantity} ${order.unit})", formatter.format(subtotal)),
          SizedBox(height: 6.h),
          _buildAmountRow("Taxes & GST (5%)", formatter.format(taxes)),
          const Divider(height: 18, thickness: 0.6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Settlement Amount",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: SHGOrderManageScreen.textDark,
                ),
              ),
              Text(
                formatter.format(order.totalPrice),
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: SHGOrderManageScreen.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 6. Bottom Action Bar (Status Transition Trigger) ---
  Widget _buildBottomActionBar(OrderModel order) {
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
          onPressed:
          isCompleted ? null : () => _showStatusUpdateBottomSheet(order),
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
            backgroundColor: SHGOrderManageScreen.primaryColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      ),
    );
  }

  // --- 7. Modal Bottom Sheet for Status Update ---
  void _showStatusUpdateBottomSheet(OrderModel order) {
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
                      "Update Order Status",
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: SHGOrderManageScreen.textDark,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(sheetContext),
                    ),
                  ],
                ),
                Text(
                  "Select fulfillment status for #${order.id.length > 8 ? order.id.substring(order.id.length - 8) : order.id}",
                  style: GoogleFonts.poppins(
                      fontSize: 11.sp, color: SHGOrderManageScreen.textMuted),
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
                      selectedColor: SHGOrderManageScreen.primaryColor,
                      backgroundColor: const Color(0xffF0F0F0),
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight:
                        isCurrent ? FontWeight.w700 : FontWeight.w500,
                        color: isCurrent
                            ? Colors.white
                            : SHGOrderManageScreen.textDark,
                      ),
                      onSelected: (selected) {
                        if (selected && !isCurrent) {
                          // Mutate live Riverpod state
                          ref
                              .read(ShgorderlistProvider.notifier)
                              .updateOrderStatus(order.id, status);

                          Navigator.pop(sheetContext);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Order status updated to ${status.name}!",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                              backgroundColor: const  Color(0xff880D4F),
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

  // --- Helpers ---
  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: GoogleFonts.poppins(
                fontSize: 11.sp, color: SHGOrderManageScreen.textMuted)),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: SHGOrderManageScreen.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildAmountRow(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: GoogleFonts.poppins(
                fontSize: 11.sp, color: SHGOrderManageScreen.textMuted)),
        Text(
          amount,
          style: GoogleFonts.poppins(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: SHGOrderManageScreen.textDark,
          ),
        ),
      ],
    );
  }
}