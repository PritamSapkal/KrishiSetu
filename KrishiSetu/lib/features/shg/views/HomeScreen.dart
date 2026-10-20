import 'package:flutter/cupertino.dart';
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
import '../../../../core/utils/GreetingFunction.dart';
import '../../fpo/dummydata/ProductListingDummyData.dart';
import '../../fpo/viewmodels/ProduceListRiverpod.dart';
import '../dummydata/MockShgData.dart';
import '../viewmodels/BottomIndexRiverpod.dart';
import '../viewmodels/MemberListRiverpod.dart';
import '../viewmodels/SHGOrderListRiverpod.dart';
import 'SHGAddProduceScreen.dart';
import 'SHGOrderManageScreen.dart';
import 'ShgAddMemberScreen.dart';

class ShgHomescreen extends ConsumerStatefulWidget {
  const ShgHomescreen({super.key});

  @override
  ConsumerState<ShgHomescreen> createState() => _ShgHomescreenState();
}

class _ShgHomescreenState extends ConsumerState<ShgHomescreen> {
  // Brand Colors
  static const Color primaryColor = Color(0xff880D4F);
  static const Color backgroundColor = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);

  // SHG Data
  final shgAuth = MockShgData.mockShgAuth;
  final shgProfile = MockShgData.mockShgProfile;

  @override
  Widget build(BuildContext context) {
    final int listingProductsCount = ref.watch(ProduceListProvider).length;
    final int membersCount = ref.watch(MemberlistProvider).length;
    final List<OrderModel> orders = ref.watch(ShgorderlistProvider);

    // Filter for active orders needing immediate fulfillment action
    final List<OrderModel> actionRequiredOrders = orders
        .where((o) => o.status == OrderStatus.PENDING || o.status == OrderStatus.CONFIRMED)
        .toList();

    // Total volume calculation across current products
    final double totalProduceQuantity = mockProductList.fold(
      0.0,
          (sum, item) => sum + ((item.quantity ?? 0).toDouble()),
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Header Banner (SHG Name, Activity & Location)
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
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${getGreeting()},",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 18.sp,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      shgProfile.shgName ?? "Mahila Bachat Gat",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                          color: Colors.white.withOpacity(0.8),
                          size: 11.sp,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "${shgProfile.village}, ${shgProfile.taluka}, ${shgProfile.district}",
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
              child: Customtitle(
                title: "Dashboard Overview",
                size: 15.sp,
              ),
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
                    // Members Metric
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref.read(ShgBottomIndexProvider.notifier).update((state) => 3);
                      },
                      child: Dashboardoverviewcart(
                        carttitle: "Members",
                        icon: Icons.groups_outlined,
                        iconColor: primaryColor,
                        widget: Customtitle(
                          title: membersCount.toString(),
                          size: 24.sp,
                        ),
                      ),
                    ),

                    // Processed Produce Metric
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref.read(ShgBottomIndexProvider.notifier).update((state) => 1);
                      },
                      child: Dashboardoverviewcart(
                        carttitle: "Produce",
                        icon: Icons.bakery_dining_outlined,
                        iconColor: const Color(0xff2E7D32),
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Customtitle(
                              title: totalProduceQuantity.toStringAsFixed(0),
                              size: 22.sp,
                            ),
                            Text(
                              " Units",
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

                    // Listings Metric
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref.read(ShgBottomIndexProvider.notifier).update((state) => 1);
                      },
                      child: Dashboardoverviewcart(
                        carttitle: "Listings",
                        icon: Icons.list_alt_outlined,
                        iconColor: const Color(0xff0277BD),
                        widget: Customtitle(
                          title: listingProductsCount.toString(),
                          size: 24.sp,
                        ),
                      ),
                    ),

                    // Sales Valuation Metric
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {},
                      child: Dashboardoverviewcart(
                        carttitle: "Sales",
                        icon: Icons.currency_rupee_sharp,
                        iconColor: const Color(0xffC62828),
                        widget: Customtitle(
                          title: "₹1.8L",
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
              child: Customtitle(
                title: "Quick Actions",
                size: 15.sp,
              ),
            ),

            // 5. Gridview: Quick Actions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                width: double.infinity,
                height: 200.h,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  mainAxisExtent: 90.h,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // Add Product
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SHGAddProduceScreen()),
                        );
                      },
                      child: Quickactioncart(
                        icon: Icons.add_box_outlined,
                        iconcolor: primaryColor,
                        iconsize: 22.sp,
                        label: "Add Product",
                      ),
                    ),

                    // Add Member
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ShgAddMemberScreen()),
                        );
                      },
                      child: Quickactioncart(
                        icon: Icons.person_add_alt_outlined,
                        iconcolor: primaryColor,
                        iconsize: 22.sp,
                        label: "Add Member",
                      ),
                    ),

                    // View Orders
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref.read(ShgBottomIndexProvider.notifier).update((state) => 2);
                      },
                      child: Quickactioncart(
                        icon: Icons.receipt_long_sharp,
                        iconcolor: primaryColor,
                        iconsize: 22.sp,
                        label: "View Orders",
                      ),
                    ),

                    // Buyer Requests
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {},
                      child: Quickactioncart(
                        icon: Icons.campaign_outlined,
                        iconcolor: primaryColor,
                        iconsize: 22.sp,
                        label: "Buyer Reqs",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 6. Action Required Section Header
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 14.h, 15.w, 8.h),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline_sharp,
                    color: const Color(0xffBA1A19),
                    size: 20.sp,
                  ),
                  SizedBox(width: 5.w),
                  Customtitle(
                    title: "Action Required (${actionRequiredOrders.length})",
                    size: 15.sp,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      ref.read(ShgBottomIndexProvider.notifier).update((state) => 2);
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

            // 7. Recent / Urgent Orders List
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
                          "No pending orders! All set.",
                          style: GoogleFonts.poppins(fontSize: 11.sp, color: textMuted),
                        ),
                      ],
                    ),
                  ),
                )
                    : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                  actionRequiredOrders.length > 3 ? 3 : actionRequiredOrders.length,
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SHGOrderManageScreen(orderId: order.id),
          ),
        );
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
                    Icons.bakery_dining_outlined,
                    color: primaryColor,
                    size: 22,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // Order & Product Info
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