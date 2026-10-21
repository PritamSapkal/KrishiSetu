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
import '../../../../features/fpo/viewmodels/FPO_totalproducesProvider.dart';
import '../../../farmer/viewmodels/bottomAppbarIndexProvider.dart';
import '../../dummydata/MockFpoData.dart';
import '../../dummydata/ProductListingDummyData.dart';
import '../../dummydata/farmer_dummy_data.dart';
import '../../models/FpoAuthModel.dart';
import '../../models/FpoProfileModel.dart';
import '../../viewmodels/FPOBottomAppbarIndexRiverpod.dart';
import '../../viewmodels/FPO_OrderListRiverpod.dart';
import 'AddFarmerScreen.dart';
import 'AddProduceScreen.dart';
import 'OrderManageScreen.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});

  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  static const Color primaryBrown = Color(0xff964900);
  static const Color scaffoldBg = Color(0xffF8F9FA);
  static const Color textDark = Color(0xff1E1E1E);
  static const Color textMuted = Color(0xff757575);

  final FpoAuthModel fpoData = MockFpoData.mockFpoAuth;
  final FpoProfileModel fpoProfile = MockFpoData.mockFpoProfile;

  @override
  Widget build(BuildContext context) {
    // 1. Watch live state from Riverpod
    final List<OrderModel> orders = ref.watch(FPOorderlistProvider);
    final int listingProductsCount = mockProductList.length;

    // 2. Filter for urgent action-required orders (PENDING or CONFIRMED)
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
            // Top FPO Name and Location Block
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryBrown,
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
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 18.sp, color: Colors.white70),
                    ),
                    Text(
                      fpoProfile.fpoName.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: Colors.white.withOpacity(0.8),
                          size: 11.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "${fpoProfile.district} District, ${fpoProfile.state}",
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

            // Dashboard Overview Title
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 18.h, 15.w, 10.h),
              child: Customtitle(title: "Dashboard Overview", size: 15.sp),
            ),

            // GridView: Dashboard Overview Cards
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
                    // Farmers
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref.read(FpoBottomAppbarindexProvider.notifier).update((state) => 3);
                      },
                      child: Dashboardoverviewcart(
                        carttitle: "Farmers",
                        icon: Icons.people_alt_outlined,
                        iconColor: primaryBrown,
                        widget: Customtitle(
                          title: farmerslist.length.toString(),
                          size: 24.sp,
                        ),
                      ),
                    ),

                    // Produce
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref.read(FpoBottomAppbarindexProvider.notifier).update((state) => 1);
                      },
                      child: Dashboardoverviewcart(
                        carttitle: "Produce",
                        icon: Icons.energy_savings_leaf_outlined,
                        iconColor: const Color(0xff328035),
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Customtitle(
                              title: ref.watch(totalProducesProvider).toStringAsFixed(0),
                              size: 22.sp,
                            ),
                            Text(
                              "  Tons",
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    // Listings
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref.read(FpoBottomAppbarindexProvider.notifier).update((state) => 1);
                      },
                      child: Dashboardoverviewcart(
                        carttitle: "Listings",
                        icon: Icons.list_outlined,
                        iconColor: const Color(0xff0277BD),
                        widget: Customtitle(
                          title: listingProductsCount.toString(),
                          size: 24.sp,
                        ),
                      ),
                    ),

                    // Sales
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {},
                      child: Dashboardoverviewcart(
                        carttitle: "Sales",
                        icon: Icons.currency_rupee_sharp,
                        iconColor: const Color(0xffC62828),
                        widget: Customtitle(title: "₹2.4L", size: 24.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Quick Actions Title
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 12.h),
              child: Customtitle(title: "Quick Actions", size: 15.sp),
            ),

            // GridView: Quick Actions
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
                    // Add Produce
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Addproducescreen()),
                        );
                      },
                      child: Quickactioncart(
                        icon: Icons.add_box_outlined,
                        iconcolor: primaryBrown,
                        iconsize: 22.sp,
                        label: "Add Produce",
                      ),
                    ),

                    // Add Farmer
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddNewFarmer()),
                        );
                      },
                      child: Quickactioncart(
                        icon: Icons.people_alt_outlined,
                        iconcolor: primaryBrown,
                        iconsize: 22.sp,
                        label: "Add Farmer",
                      ),
                    ),

                    // View Orders
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref.read(FpoBottomAppbarindexProvider.notifier).update((state) => 2);
                      },
                      child: Quickactioncart(
                        icon: Icons.receipt_long_sharp,
                        iconcolor: primaryBrown,
                        iconsize: 22.sp,
                        label: "View Orders",
                      ),
                    ),

                    // Buyer Reqs
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {},
                      child: Quickactioncart(
                        icon: Icons.campaign_outlined,
                        iconcolor: primaryBrown,
                        iconsize: 22.sp,
                        label: "Buyer Reqs",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Action Required Title Bar
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
                      ref.read(FpoBottomAppbarindexProvider.notifier).update((state) => 2);
                    },
                    child: Text(
                      "View All",
                      style: GoogleFonts.poppins(
                        color: primaryBrown,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Action Required Orders List Card
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
                    )
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
                          "All orders are fulfilled or dispatched!",
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
                  separatorBuilder: (context, index) => const Divider(height: 1, thickness: 0.6),
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
            builder: (context) => OrderManagescreen(orderid: order.id),
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
                  child: Icon(Icons.eco, color: primaryBrown, size: 22.sp),
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
                    order.name.toUpperCase(),
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
                    color: primaryBrown,
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