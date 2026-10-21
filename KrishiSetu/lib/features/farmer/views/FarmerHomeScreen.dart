import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/Widgets/DashBoardOverviewCart.dart';
import '../../../../core/Widgets/QuickActionCart.dart';
import '../../../../core/Widgets/customTitle.dart';
import '../../../../core/models/OrderModel.dart';
import '../../../../core/models/ProductModel.dart';
import '../../../../core/utils/GreetingFunction.dart';

// Farmer Providers & Mock Data
import '../dummydata/mock_farmer_data.dart';
import '../viewmodels/FarmerOrderListRiverpod.dart';
import '../viewmodels/FarmerProductListRiverpod.dart';
import '../viewmodels/bottomAppbarIndexProvider.dart';

class FarmerHomeScreen extends ConsumerStatefulWidget {
  const FarmerHomeScreen({super.key});

  @override
  ConsumerState<FarmerHomeScreen> createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends ConsumerState<FarmerHomeScreen> {
  static const Color primaryColor = Color(0xff2E7D32);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);

  final farmerAuth = MockFarmerData.mockFarmerAuth;
  final farmerProfile = MockFarmerData.mockFarmerProfile;

  @override
  Widget build(BuildContext context) {
    // Watch live Riverpod state
    final List<ProductModel> products = ref.watch(FarmerProductListProvider);
    final List<OrderModel> orders = ref.watch(FarmerOrderListProvider);

    // Calculate total crop volume across current listings
    final double totalHarvestStock = products.fold(
      0.0,
          (sum, item) => sum + (item.quantity ?? 0.0),
    );

    // Action required orders (Pending or Confirmed)
    final List<OrderModel> actionRequiredOrders = orders
        .where((o) => o.status == OrderStatus.PENDING || o.status == OrderStatus.CONFIRMED)
        .toList();

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Farmer Header Banner
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${getGreeting()},",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      farmerAuth.user?.name ?? "Farmer",
                      style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: Colors.white.withOpacity(0.85),
                          size: 11.sp,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "${farmerProfile.village}, ${farmerProfile.taluka}, ${farmerProfile.district}",
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.85),
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 2. Dashboard Overview Title
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 18.h, 15.w, 10.h),
              child: Customtitle(title: "Farm Overview", size: 15.sp),
            ),

            // 3. Gridview: Dashboard Overview Metrics
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                width: double.infinity,
                height: 220.h,
                child: GridView.count(
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  mainAxisExtent: 100.h,
                  children: [
                    // Land Holding
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {},
                      child: Dashboardoverviewcart(
                        carttitle: "Land Holding",
                        icon: Icons.landscape_outlined,
                        iconColor: primaryColor,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Customtitle(
                              title: "${farmerProfile.farmSize ?? 1.0}",
                              size: 24.sp,
                            ),
                            Text(
                              " ${farmerProfile.farmSizeUnit ?? 'Acre'}",
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Harvest Stock Volume
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref.read(FarmerBottomAppbarIndexProvider.notifier).update((state) => 1);
                      },
                      child: Dashboardoverviewcart(
                        carttitle: "Harvest Stock",
                        icon: Icons.grain_outlined,
                        iconColor: const Color(0xffE07525),
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Customtitle(
                              title: totalHarvestStock.toStringAsFixed(0),
                              size: 22.sp,
                            ),
                            Text(
                              " Qtl/Kg",
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Listed Crops
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref.read(FarmerBottomAppbarIndexProvider.notifier).update((state) => 1);
                      },
                      child: Dashboardoverviewcart(
                        carttitle: "Listed Crops",
                        icon: Icons.list_alt_outlined,
                        iconColor: const Color(0xff0277BD),
                        widget: Customtitle(
                          title: products.length.toString(),
                          size: 24.sp,
                        ),
                      ),
                    ),

                    // Crop Sales
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {},
                      child: Dashboardoverviewcart(
                        carttitle: "Crop Sales",
                        icon: Icons.currency_rupee_sharp,
                        iconColor: const Color(0xffC62828),
                        widget: Customtitle(
                          title: "₹1.4L",
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 4. Quick Actions Title
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 12.h),
              child: Customtitle(title: "Quick Actions", size: 15.sp),
            ),

            // 5. Quick Actions Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        // Navigate to Farmer Add Produce Screen
                      },
                      child: Quickactioncart(
                        icon: Icons.add_box_outlined,
                        iconcolor: primaryColor,
                        iconsize: 22.sp,
                        label: "Sell Produce",
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref.read(FarmerBottomAppbarIndexProvider.notifier).update((state) => 2);
                      },
                      child: Quickactioncart(
                        icon: Icons.shopping_bag_outlined,
                        iconcolor: primaryColor,
                        iconsize: 22.sp,
                        label: "View Orders",
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 6. Action Required Section Header
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 16.h, 15.w, 8.h),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline_sharp,
                    color: const Color(0xffBA1A19),
                    size: 18.sp,
                  ),
                  SizedBox(width: 6.w),
                  Customtitle(
                    title: "Action Required (${actionRequiredOrders.length})",
                    size: 15.sp,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      ref.read(FarmerBottomAppbarIndexProvider.notifier).update((state) => 2);
                    },
                    child: Text(
                      "View All",
                      style: GoogleFonts.poppins(
                        color: primaryColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 7. Action Required Orders List Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 5,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: actionRequiredOrders.isEmpty
                    ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.green, size: 28.sp),
                        SizedBox(height: 6.h),
                        Text(
                          "No pending orders! All harvested batches fulfilled.",
                          style: GoogleFonts.poppins(fontSize: 11.sp, color: textMuted),
                        ),
                      ],
                    ),
                  ),
                )
                    : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: actionRequiredOrders.length > 3 ? 3 : actionRequiredOrders.length,
                  separatorBuilder: (context, index) =>
                  const Divider(height: 1, thickness: 0.6),
                  itemBuilder: (context, index) {
                    final order = actionRequiredOrders[index];
                    return _buildActionOrderItem(order);
                  },
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  // --- Subcomponent: Action Required Order Item Tile ---
  Widget _buildActionOrderItem(OrderModel order) {
    final formattedDate = DateFormat('dd MMM, hh:mm a').format(order.createdAt);
    final isPending = order.status == OrderStatus.PENDING;

    return InkWell(
      onTap: () {
        // Navigate to Farmer Order Manage Screen passing order.id
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                order.imageUrl,
                width: 44.r,
                height: 44.r,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 44.r,
                  height: 44.r,
                  color: const Color(0xffECEFEF),
                  child: const Icon(
                    Icons.eco_outlined,
                    color: primaryColor,
                    size: 22,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // Order & Crop Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "#${order.id.length > 8 ? order.id.substring(order.id.length - 8) : order.id}",
                        style: GoogleFonts.poppins(
                          color: textMuted,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        formattedDate,
                        style: GoogleFonts.poppins(color: textMuted, fontSize: 9.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    order.name,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      // Status Badge
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: isPending
                              ? const Color(0xffFFF4E5)
                              : const Color(0xffE3F2FD),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          order.status.name,
                          style: GoogleFonts.poppins(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: isPending
                                ? const Color(0xffB76E00)
                                : const Color(0xff1565C0),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "${order.quantity} ${order.unit}",
                        style: GoogleFonts.poppins(fontSize: 10.sp, color: textDark),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),

            // Price & Forward Icon
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "₹${order.totalPrice.toStringAsFixed(0)}",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13.sp,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}