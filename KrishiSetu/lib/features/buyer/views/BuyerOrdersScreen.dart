import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/models/OrderModel.dart';
import '../viewmodels/buyer_order_riverpod.dart';

class BuyerOrdersScreen extends ConsumerStatefulWidget {
  const BuyerOrdersScreen({super.key});

  @override
  ConsumerState<BuyerOrdersScreen> createState() => _BuyerOrdersScreenState();
}

class _BuyerOrdersScreenState extends ConsumerState<BuyerOrdersScreen> {
  static const Color primaryColor = Color(0xff004D40); // Deep Emerald Teal
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff8A9099);

  String selectedTab = "All";
  final List<String> tabs = ["All", "Pending", "Active", "Delivered", "Cancelled"];

  final currencyFormatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    final List<OrderModel> orders = ref.watch(buyerOrderListProvider);

    final filteredOrders = orders.where((order) {
      if (selectedTab == "All") return true;
      if (selectedTab == "Pending") return order.status == OrderStatus.PENDING;
      if (selectedTab == "Active") {
        return order.status == OrderStatus.CONFIRMED ||
            order.status == OrderStatus.PROCESSING ||
            order.status == OrderStatus.SHIPPED;
      }
      if (selectedTab == "Delivered") return order.status == OrderStatus.DELIVERED;
      if (selectedTab == "Cancelled") return order.status == OrderStatus.CANCELLED;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: Column(
        children: [
          // Filter Tabs
          _buildFilterTabs(),

          // Orders List
          Expanded(
            child: filteredOrders.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long_outlined, size: 48.sp, color: Colors.grey.shade400),
                  SizedBox(height: 10.h),
                  Text(
                    "No orders found in $selectedTab",
                    style: GoogleFonts.poppins(fontSize: 13.sp, color: textMuted),
                  ),
                ],
              ),
            )
                : ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              itemCount: filteredOrders.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
                return _buildBuyerOrderCard(order);
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- Filter Tabs ---
  Widget _buildFilterTabs() {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.map((tab) {
            final isSelected = selectedTab == tab;
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: GestureDetector(
                onTap: () {
                  setState(() => selectedTab = tab);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected ? primaryColor : const Color(0xffE2E5EA),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tab,
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? Colors.white : const Color(0xff6C727F),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // --- Buyer Order Card ---
  Widget _buildBuyerOrderCard(OrderModel order) {
    final formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(order.createdAt);
    final canCancel = order.status == OrderStatus.PENDING;

    return Container(
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
          // Order ID & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ORDER ID", style: GoogleFonts.poppins(fontSize: 9.sp, color: textMuted, fontWeight: FontWeight.w600)),
                  Text(
                    "#${order.id.length > 8 ? order.id.substring(order.id.length - 8) : order.id}",
                    style: GoogleFonts.poppins(fontSize: 13.sp, fontWeight: FontWeight.bold, color: textDark),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildStatusBadge(order.status),
                  SizedBox(height: 3.h),
                  Text(formattedDate, style: GoogleFonts.poppins(fontSize: 9.sp, color: textMuted)),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Product Image & Info
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  order.imageUrl,
                  width: 50.r,
                  height: 50.r,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 50.r,
                    height: 50.r,
                    color: const Color(0xffECEFEF),
                    child: const Icon(Icons.eco_outlined, color: primaryColor),
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
                      "${order.quantity} ${order.unit} • ₹${order.pricePerUnit.toStringAsFixed(0)}/${order.unit}",
                      style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Total & Optional Cancel Trigger
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Price", style: GoogleFonts.poppins(fontSize: 9.sp, color: textMuted)),
                  Text(
                    currencyFormatter.format(order.totalPrice),
                    style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                ],
              ),
              if (canCancel)
                TextButton.icon(
                  onPressed: () => _confirmCancelOrder(order.id),
                  icon: const Icon(Icons.cancel_outlined, color: Colors.red, size: 16),
                  label: Text(
                    "Cancel Order",
                    style: GoogleFonts.poppins(color: Colors.red, fontSize: 11.sp, fontWeight: FontWeight.w600),
                  ),
                )
              else
                Row(
                  children: [
                    Icon(Icons.payment_outlined, size: 14.sp, color: const Color(0xff2E7D32)),
                    SizedBox(width: 4.w),
                    Text(
                      "Pay on Delivery",
                      style: GoogleFonts.poppins(fontSize: 10.sp, fontWeight: FontWeight.w600, color: const Color(0xff2E7D32)),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmCancelOrder(String orderId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Cancel Order?", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15.sp)),
        content: Text("Are you sure you want to cancel this order?", style: GoogleFonts.poppins(fontSize: 12.sp)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Keep Order")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              ref.read(buyerOrderListProvider.notifier).cancelOrder(orderId);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Order cancelled successfully"), backgroundColor: Colors.red),
              );
            },
            child: const Text("Yes, Cancel", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(OrderStatus status) {
    Color bg;
    Color fg;

    switch (status) {
      case OrderStatus.PENDING:
        bg = const Color(0xffFFF4E5);
        fg = const Color(0xffB76E00);
        break;
      case OrderStatus.CONFIRMED:
        bg = const Color(0xffE3F2FD);
        fg = const Color(0xff1565C0);
        break;
      case OrderStatus.PROCESSING:
        bg = const Color(0xffF3E5F5);
        fg = const Color(0xff7B1FA2);
        break;
      case OrderStatus.SHIPPED:
        bg = const Color(0xffE8EAF6);
        fg = const Color(0xff283593);
        break;
      case OrderStatus.DELIVERED:
        bg = const Color(0xffEAF7ED);
        fg = const Color(0xff2E7D32);
        break;
      case OrderStatus.CANCELLED:
        bg = const Color(0xffFFEBEE);
        fg = const Color(0xffC62828);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10.r)),
      child: Text(
        status.name,
        style: GoogleFonts.poppins(fontSize: 9.sp, fontWeight: FontWeight.w700, color: fg),
      ),
    );
  }
}