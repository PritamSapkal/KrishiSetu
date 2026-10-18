import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/Widgets/DashBoardOverviewCart.dart';
import '../../../../core/Widgets/QuickActionCart.dart';
import '../../../../core/Widgets/customTitle.dart';
import '../../../../core/utils/GreetingFunction.dart';
import '../../farmer/viewmodels/bottomAppbarIndexProvider.dart';
import '../../fpo/dummydata/OrderDummyList.dart';
import '../../fpo/dummydata/ProductListingDummyData.dart';
import '../../fpo/viewmodels/ProduceListRiverpod.dart';
import '../dummydata/MockShgData.dart';
import '../dummydata/ShgMember_DummyData.dart';
import '../dummydata/Shg_OrderDummyList.dart';
import '../viewmodels/BottomIndexRiverpod.dart';
import '../viewmodels/MemberListRiverpod.dart';
import 'SHGAddProduceScreen.dart';
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

  // SHG Data
  final shgAuth = MockShgData.mockShgAuth;
  final shgProfile = MockShgData.mockShgProfile;

  @override
  Widget build(BuildContext context) {
    final int listingProductsCount = ref.watch(ProduceListProvider).length;
    final int membersCount = ref.watch(MemberlistProvider).length;

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
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${getGreeting()},",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 20.sp,
                        color: Colors.white,
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
                          size: 12.sp,
                        ),
                        SizedBox(width: 4.w),
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
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
              child: Customtitle(
                title: "Dashboard Overview",
                size: 15.sp,
              ),
            ),

            // 3. Gridview: Dashboard Overview Metrics
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 220.h,
                child: GridView.count(
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10.sp,
                  mainAxisSpacing: 10.sp,
                  mainAxisExtent: 100.sp,
                  children: [
                    // Members Metric
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        ref.read(ShgBottomIndexProvider.notifier).update((state) => 3);
                      },
                      child: Dashboardoverviewcart(
                        carttitle: "Members",
                        icon: Icons.groups_outlined,
                        iconColor: primaryColor,
                        widget: Customtitle(
                          title: membersCount.toString(),
                          size: 25.sp,
                        ),
                      ),
                    ),

                    // Processed Produce Metric
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
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
                              size: 23.sp,
                            ),
                            Text(
                              " Units",
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

                    // Listings Metric
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        ref.read(ShgBottomIndexProvider.notifier).update((state) => 1);
                      },
                      child: Dashboardoverviewcart(
                        carttitle: "Listings",
                        icon: Icons.list_alt_outlined,
                        iconColor: const Color(0xff0277BD),
                        widget: Customtitle(
                          title: listingProductsCount.toString(),
                          size: 25.sp,
                        ),
                      ),
                    ),

                    // Sales Valuation Metric
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {},
                      child: Dashboardoverviewcart(
                        carttitle: "Sales",
                        icon: Icons.currency_rupee_sharp,
                        iconColor: const Color(0xffC62828),
                        widget: Customtitle(
                          title: "₹1.8L",
                          size: 25.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 4. Quick Actions Title
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
              child: Customtitle(
                title: "Quick Actions",
                size: 15.sp,
              ),
            ),

            // 5. Gridview: Quick Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 200.h,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.sp,
                  mainAxisSpacing: 10.sp,
                  mainAxisExtent: 90.sp,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // Add Product
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>SHGAddProduceScreen()));
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
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>ShgAddMemberScreen()));
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
                      borderRadius: BorderRadius.circular(20),
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
                      borderRadius: BorderRadius.circular(20),
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
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.error_outline_sharp,
                    color: const Color(0xffBA1A19),
                    size: 20.sp,
                  ),
                  SizedBox(width: 5.w),
                  Customtitle(title: "Action Required", size: 15.sp),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      ref.read(ShgBottomIndexProvider.notifier).update((state) => 2);
                    },
                    child: Text(
                      "View All",
                      style: GoogleFonts.poppins(
                        color: primaryColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 7. Recent / Urgent Orders List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
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
                height: 280.h,
                width: double.infinity,
                child: ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  itemCount: mockShgOrderList.length > 3 ? 3 : mockShgOrderList.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final order = mockShgOrderList[index];
                    return Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Order ID
                          Text(
                            "#${order.id.length > 8 ? order.id.substring(order.id.length - 8) : order.id}",
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.h),

                          // Product Name
                          Customtitle(
                            title: order.name.toUpperCase(),
                            size: 14.sp,
                          ),
                          SizedBox(height: 4.h),

                          // Status and Price Badge Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    color: const Color(0xff585F6C),
                                    size: 14.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    order.status.name,
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff585F6C),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "₹${order.totalPrice.toStringAsFixed(0)}",
                                style: GoogleFonts.poppins(
                                  color: primaryColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}