import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/OrderModel.dart';
import '../../viewmodels/FPO_OrderListRiverpod.dart';

class OrderManagescreen extends ConsumerStatefulWidget {
  const OrderManagescreen({required this.orderid, super.key});
  final String orderid;

  static const Color primaryBrown = Color(0xff964900);
  static const Color accentOrange = Color(0xffE07525);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);
  static const Color cardSubBg = Color(0xffFAF0E6);

  @override
  ConsumerState<OrderManagescreen> createState() => _OrderManagescreenState();
}

class _OrderManagescreenState extends ConsumerState<OrderManagescreen> {
  @override
  Widget build(BuildContext context) {
    // Watch the live order list from Riverpod
    final List<OrderModel> orders = ref.watch(FPOorderlistProvider);

    final OrderModel? order = orders.cast<OrderModel?>().firstWhere(
          (o) => o?.id == widget.orderid,
      orElse: () => null,
    );

    final currencyFormatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    // Gracefully handle if order is not found
    if (order == null) {
      return Scaffold(
        backgroundColor: OrderManagescreen.scaffoldBg,
        appBar: AppBar(
          backgroundColor: OrderManagescreen.primaryBrown,
          foregroundColor: Colors.white,
          title: Text(
            "Order Not Found",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ),
        body: Center(
          child: Text(
            "Order #${widget.orderid} could not be found.",
            style: GoogleFonts.poppins(color: OrderManagescreen.textMuted, fontSize: 13.sp),
          ),
        ),
      );
    }

    // Derived subtotal and tax calculation based on 5% GST
    final double subtotal = order.totalPrice / 1.05;
    final double taxes = order.totalPrice - subtotal;

    return Scaffold(
      backgroundColor: OrderManagescreen.scaffoldBg,
      appBar: AppBar(
        backgroundColor: OrderManagescreen.primaryBrown,
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
      bottomNavigationBar: _buildBottomActionBar(context, order),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Column(
          children: [
            // 1. Status & Lifecycle Card
            _buildStatusCard(order),
            SizedBox(height: 12.h),

            // 2. Order Information Card
            _buildOrderInfoCard(order),
            SizedBox(height: 12.h),

            // 3. Product Details Card
            _buildProductDetailsCard(order),
            SizedBox(height: 12.h),

            // 4. Buyer Information Card
            _buildBuyerInfoCard(order),
            SizedBox(height: 12.h),

            // 5. Payment Summary Card
            _buildPaymentSummaryCard(order, subtotal, taxes, currencyFormatter),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  // --- 1. Status & Lifecycle Card ---
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
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ORDER STATUS",
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: OrderManagescreen.textMuted,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(statusIcon, color: statusColor, size: 18.sp),
              SizedBox(width: 6.w),
              Text(
                order.status.name,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
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
                  order.status == OrderStatus.DELIVERED || order.status == OrderStatus.CANCELLED
                      ? "Completed"
                      : "In Progress",
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
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
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
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
              color: OrderManagescreen.textDark,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order ID", style: GoogleFonts.poppins(fontSize: 10.sp, color: OrderManagescreen.textMuted)),
                  Text(
                    "#${order.id}",
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: OrderManagescreen.textDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Created At", style: GoogleFonts.poppins(fontSize: 10.sp, color: OrderManagescreen.textMuted)),
                  Text(
                    formattedCreated,
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: OrderManagescreen.textDark,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Last Updated", style: GoogleFonts.poppins(fontSize: 10.sp, color: OrderManagescreen.textMuted)),
                  Text(
                    formattedUpdated,
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: OrderManagescreen.textDark,
                    ),
                  ),
                ],
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
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product Details",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: OrderManagescreen.textDark,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Image.network(
                  order.imageUrl,
                  width: 58.r,
                  height: 58.r,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 58.r,
                    height: 58.r,
                    color: const Color(0xffECEFEF),
                    child: const Icon(Icons.eco, color: OrderManagescreen.primaryBrown),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.name.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: OrderManagescreen.textDark,
                      ),
                    ),
                    Text(
                      "Product ID: #${order.productId.length > 8 ? order.productId.substring(order.productId.length - 8) : order.productId}",
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        color: OrderManagescreen.textMuted,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: OrderManagescreen.cardSubBg,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "Qty: ${order.quantity} ${order.unit} @ ₹${order.pricePerUnit.toStringAsFixed(0)}/${order.unit}",
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: OrderManagescreen.textDark,
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
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Buyer Information",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: OrderManagescreen.textDark,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: OrderManagescreen.accentOrange,
                child: Text(
                  "B",
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
                      "Buyer ID: #${order.buyerId}",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: OrderManagescreen.textDark,
                      ),
                    ),
                    Text(
                      "Verified Platform Buyer",
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        color: OrderManagescreen.textMuted,
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
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Summary",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: OrderManagescreen.textDark,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal (${order.quantity} ${order.unit})",
                style: GoogleFonts.poppins(fontSize: 11.sp, color: OrderManagescreen.textMuted),
              ),
              Text(
                formatter.format(subtotal),
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: OrderManagescreen.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Taxes & GST (5%)",
                style: GoogleFonts.poppins(fontSize: 11.sp, color: OrderManagescreen.textMuted),
              ),
              Text(
                formatter.format(taxes),
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: OrderManagescreen.textDark,
                ),
              ),
            ],
          ),
          const Divider(height: 18, thickness: 0.6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Paid",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: OrderManagescreen.textDark,
                ),
              ),
              Text(
                formatter.format(order.totalPrice),
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: OrderManagescreen.primaryBrown,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 6. Bottom Action Bar ---
  Widget _buildBottomActionBar(BuildContext context, OrderModel order) {
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
          onPressed: isCompleted ? null : () => _showStatusUpdateBottomSheet(context, order),
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
            backgroundColor: OrderManagescreen.primaryBrown,
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
  void _showStatusUpdateBottomSheet(BuildContext context, OrderModel order) {
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
                        color: OrderManagescreen.textDark,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(sheetContext),
                    ),
                  ],
                ),
                Text(
                  "Select the fulfillment state for #${order.id.length > 8 ? order.id.substring(order.id.length - 8) : order.id}",
                  style: GoogleFonts.poppins(fontSize: 11.sp, color: OrderManagescreen.textMuted),
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
                      selectedColor: OrderManagescreen.primaryBrown,
                      backgroundColor: const Color(0xffF0F0F0),
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                        color: isCurrent ? Colors.white : OrderManagescreen.textDark,
                      ),
                      onSelected: (selected) {
                        if (selected && !isCurrent) {
                          // Update FPO Riverpod State
                          ref
                              .read(FPOorderlistProvider.notifier)
                              .updateOrderStatus(order.id, status);

                          Navigator.pop(sheetContext);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Order status updated to ${status.name}!",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                              backgroundColor: const  Color(0xff964900),
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
}