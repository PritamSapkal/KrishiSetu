import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/models/OrderModel.dart';
import '../viewmodels/FarmerOrderListRiverpod.dart';
import 'FarmerOrderManageScreen.dart'; // Adjust path as needed

class FarmerOrderScreen extends ConsumerStatefulWidget {
  const FarmerOrderScreen({super.key});

  @override
  ConsumerState<FarmerOrderScreen> createState() => _FarmerOrderScreenState();
}

class _FarmerOrderScreenState extends ConsumerState<FarmerOrderScreen> {
  static const Color primaryColor = Color(0xff2E7D32);
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
    // Watch live order list from Riverpod
    final List<OrderModel> allOrders = ref.watch(FarmerOrderListProvider);

    // Filter list based on selected category tab
    final filteredOrders = allOrders.where((order) {
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
              child: Text(
                "No orders found in $selectedTab",
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  color: textMuted,
                ),
              ),
            )
                : ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              itemCount: filteredOrders.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
                return _buildOrderCard(order);
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- Horizontal Filter Tabs ---
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
                  setState(() {
                    selectedTab = tab;
                  });
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

  // --- Individual Order Card ---
  Widget _buildOrderCard(OrderModel order) {
    final formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(order.createdAt);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xffEFEFEF)),
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
          // Order ID & Status Badge Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ORDER ID",
                    style: GoogleFonts.poppins(
                      fontSize: 9.sp,
                      color: textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "#${order.id.length > 8 ? order.id.substring(order.id.length - 8) : order.id}",
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: textDark,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildStatusBadge(order.status),
                  SizedBox(height: 3.h),
                  Text(
                    formattedDate,
                    style: GoogleFonts.poppins(
                      fontSize: 9.sp,
                      color: textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Crop & Buyer Row with Network Thumbnail
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  order.imageUrl,
                  width: 48.r,
                  height: 48.r,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 48.r,
                      height: 48.r,
                      color: const Color(0xffE8F5E9),
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2, color: primaryColor),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 48.r,
                    height: 48.r,
                    color: const Color(0xffECEFEF),
                    child: Icon(Icons.eco_outlined, color: primaryColor, size: 24.sp),
                  ),
                ),
              ),
              SizedBox(width: 10.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.name,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: textDark,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Buyer Ref: #${order.buyerId.length > 6 ? order.buyerId.substring(order.buyerId.length - 6) : order.buyerId}",
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

          SizedBox(height: 10.h),

          // Quantity & Total Amount Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quantity",
                      style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                    ),
                    Text(
                      "${order.quantity} ${order.unit}",
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: textDark,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Amount",
                      style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                    ),
                    Text(
                      currencyFormatter.format(order.totalPrice),
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Farm-Gate Rate & Manage Order Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.payments_outlined,
                    size: 15.sp,
                    color: const Color(0xff2E7D32),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "₹${order.pricePerUnit.toStringAsFixed(0)} / ${order.unit}",
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff2E7D32),
                    ),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Farmerordermanagescreen(orderId: order.id),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
                  minimumSize: Size(0, 30.h),
                ),
                child: Text(
                  "Manage Order",
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Status Badge Helper ---
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
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 3.r, backgroundColor: fg),
          SizedBox(width: 4.w),
          Text(
            status.name,
            style: GoogleFonts.poppins(
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}
