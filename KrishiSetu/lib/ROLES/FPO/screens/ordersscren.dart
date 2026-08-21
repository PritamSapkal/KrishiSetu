import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../Data/FPO_Dummy_Data/Order_dummy_data.dart';
import '../../../Model/FarmerModel/OrderModel.dart';
import 'OrderDetailScreen.dart';

class Ordersscren extends StatefulWidget {
  const Ordersscren({super.key});

  @override
  State<Ordersscren> createState() => _OrdersscrenState();
}

class _OrdersscrenState extends State<Ordersscren> {
  static const Color primaryBrown = Color(0xff8D4F1E);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff8A9099);

  String selectedTab = "All";
  final List<String> tabs = ["All", "Active", "Completed", "Cancelled"];

  final currencyFormatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    // Filter list based on the active selected tab
    final filteredOrders = selectedTab == "All"
        ? orderslist
        : orderslist.where((order) => order.status.toLowerCase() == selectedTab.toLowerCase()).toList();

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
                "No orders found",
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
                return _buildOrderCard(order,index);
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tabs.map((tab) {
          final isSelected = selectedTab == tab;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = tab;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected ? primaryBrown : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? primaryBrown : const Color(0xffE2E5EA),
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
          );
        }).toList(),
      ),
    );
  }

  // --- Order Card ---
  Widget _buildOrderCard(OrderModel order, int index) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xffEFEFEF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order ID & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order id
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Id text
                  Text(
                    "ORDER ID",
                    style: GoogleFonts.poppins(
                      fontSize: 9.sp,
                      color: textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Order Id in number
                  Text(
                    "#${order.orderId}",
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: textDark,
                    ),
                  ),
                ],
              ),

              // Oredr Status & Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Order Status
                  _buildStatusBadge(order.status),

                  SizedBox(height: 3.h),

                  // Order Date
                  Text(
                    order.orderDate,
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

          // Buyer & Product Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Buyer",
                      style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                    ),
                    Text(
                      order.buyer.name,
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
                      "Product",
                      style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                    ),
                    Text(
                      "${order.product.name} (${order.product.grade})",
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: textDark,
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

              // Quantity
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quantity Text
                    Text(
                      "Quantity",
                      style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                    ),
                    // Quantity number And unit
                    Text(
                      "${order.quantity} ${order.quantityUnit}",
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
              // Total Amount
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Amount",
                      style: GoogleFonts.poppins(fontSize: 10.sp, color: textMuted),
                    ),
                    Text(
                      currencyFormatter.format(order.totalAmount),
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: primaryBrown,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Payment Status & View Details Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // Payment Status
              Row(
                children: [
                  // Payment status Icon
                  Icon(
                    Icons.payments_outlined,
                    size: 15.sp,
                    color: _getPaymentStatusColor(order.paymentStatus),
                  ),
                  SizedBox(width: 4.w),
                  // Payment status
                  Text(
                    order.paymentStatus,
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: _getPaymentStatusColor(order.paymentStatus),
                    ),
                  ),
                ],
              ),

              // View Detail Button
              OutlinedButton(
                onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Orderdetailscreen(index: index,),));
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
                  "View Details",
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: primaryBrown,
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
  Widget _buildStatusBadge(String status) {
    Color bg;
    Color fg;

    switch (status.toLowerCase()) {
      case 'completed':
        bg = const Color(0xffEAF7ED);
        fg = const Color(0xff2E7D32);
        break;
      case 'active':
        bg = const Color(0xffFFF4E5);
        fg = const Color(0xffB76E00);
        break;
      case 'cancelled':
        bg = const Color(0xffFFEBEE);
        fg = const Color(0xffC62828);
        break;
      case 'new':
        bg = const Color(0xffE3F2FD);
        fg = const Color(0xff1565C0);
        break;
      default:
        bg = const Color(0xffF0F0F0);
        fg = Colors.black54;
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
            status,
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

  // --- Payment Status Color Helper ---
  Color _getPaymentStatusColor(String paymentStatus) {
    switch (paymentStatus.toLowerCase()) {
      case 'paid':
        return const Color(0xff2E7D32);
      case 'partially paid':
        return const Color(0xffB76E00);
      case 'refunded':
        return const Color(0xffC62828);
      case 'pending':
      default:
        return const Color(0xff6C727F);
    }
  }
}