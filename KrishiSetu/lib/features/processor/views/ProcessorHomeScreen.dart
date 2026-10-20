import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/Widgets/DashBoardOverviewCart.dart';
import '../../../../core/Widgets/QuickActionCart.dart';
import '../../../../core/Widgets/customTitle.dart';
import '../../../../core/utils/GreetingFunction.dart';
import '../dummydata/MockProcessorData.dart';
import '../viewmodels/ProcessorBottomAppBarIndex.dart';
import '../viewmodels/ProcessorProductListRiverpod.dart'; // Adjust import paths
import '../viewmodels/ProcessorOrderListRiverpod.dart';
import '../../../core/models/OrderModel.dart';
import '../../../core/models/ProductModel.dart';
import 'ProcessorAddProductScreen.dart';

class Processorhomescreen extends ConsumerStatefulWidget {
  const Processorhomescreen({super.key});

  @override
  ConsumerState<Processorhomescreen> createState() => _ProcessorhomescreenState();
}

class _ProcessorhomescreenState extends ConsumerState<Processorhomescreen> {
  static const Color primaryColor = Color(0xff4A148C);
  static const Color scaffoldBg = Color(0xffF8F9FA);

  final processorProfile = MockProcessorData.mockProcessorProfile;

  @override
  Widget build(BuildContext context) {
    // Watching Riverpod state
    final List<ProductModel> products = ref.watch(ProcessorproductlistProvider);
    final List<OrderModel> orders = ref.watch(ProcessororderlistProvider);

    // Calculate total inventory quantity
    final double totalStock = products.fold(
      0.0,
          (sum, item) => sum + (item.quantity ?? 0.0),
    );

    // Calculate urgent/action required orders
    final urgentOrders = orders
        .where((o) => o.status == OrderStatus.PENDING || o.status == OrderStatus.CONFIRMED)
        .toList();

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Enterprise Banner
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
                      processorProfile.businessName ?? "Agro Processing Enterprise",
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
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
                          "${processorProfile.address}, ${processorProfile.district}",
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
              child: Customtitle(title: "Processing Plant Overview", size: 15.sp),
            ),

            // 3. Gridview Metrics (Driven by Riverpod)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                height: 220.h,
                child: GridView.count(
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  mainAxisExtent: 100.h,
                  children: [
                    // Operational Activities / Plant Capability
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {},
                      child: Dashboardoverviewcart(
                        carttitle: "Activities",
                        icon: Icons.precision_manufacturing_outlined,
                        iconColor: primaryColor,
                        widget: Customtitle(
                          title: "${processorProfile.processingActivities?.length ?? 4}",
                          size: 24.sp,
                        ),
                      ),
                    ),

                    // Inventory Stock (from ProcessorproductlistProvider)
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref.read(ProcessorBottomAppBarIndexProvider.notifier).update((state) => 1);
                      },
                      child: Dashboardoverviewcart(
                        carttitle: "Stock Volume",
                        icon: Icons.inventory_2_outlined,
                        iconColor: const Color(0xff2E7D32),
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Customtitle(
                              title: totalStock.toStringAsFixed(0),
                              size: 22.sp,
                            ),
                            Text(
                              "  Qtl/Kg",
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

                    // Active Listed SKUs (from ProcessorproductlistProvider)
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref.read(ProcessorBottomAppBarIndexProvider.notifier).update((state) => 1);
                      },
                      child: Dashboardoverviewcart(
                        carttitle: "Products",
                        icon: Icons.list_alt_outlined,
                        iconColor: const Color(0xff0277BD),
                        widget: Customtitle(
                          title: products.length.toString(),
                          size: 24.sp,
                        ),
                      ),
                    ),

                    // Orders Volume (from ProcessororderlistProvider)
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref.read(ProcessorBottomAppBarIndexProvider.notifier).update((state) => 2);
                      },
                      child: Dashboardoverviewcart(
                        carttitle: "Orders",
                        icon: Icons.receipt_long_outlined,
                        iconColor: const Color(0xffC62828),
                        widget: Customtitle(
                          title: orders.length.toString(),
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 4. Quick Actions
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 12.h, 15.w, 12.h),
              child: Customtitle(title: "Quick Actions", size: 15.sp),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  // Add product button
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>ProcessorAddProductScreen()));
                      },
                      child: Quickactioncart(
                        icon: Icons.add_box_outlined,
                        iconcolor: primaryColor,
                        iconsize: 22.sp,
                        label: "Add Product",
                      ),
                    ),
                  ),

                  SizedBox(width: 10.w),

                  // View Orders Button
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref.read(ProcessorBottomAppBarIndexProvider.notifier).update((state) => 2);
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

            // 5. Action Required Header
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 18.h, 15.w, 8.h),
              child: Row(
                children: [
                  Icon(Icons.pending_actions_rounded, color: const Color(0xffBA1A19), size: 18.sp),
                  SizedBox(width: 6.w),
                  Customtitle(title: "Action Required", size: 15.sp),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      ref.read(ProcessorBottomAppBarIndexProvider.notifier).update((state) => 2);
                    },
                    child: Text(
                      "View All (${urgentOrders.length})",
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

            // 6. Action Required Orders List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 0.5),
                  ],
                ),
                child: urgentOrders.isEmpty
                    ? Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Center(
                    child: Text(
                      "No pending processing orders",
                      style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12.sp),
                    ),
                  ),
                )
                    : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: urgentOrders.length > 3 ? 3 : urgentOrders.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final order = urgentOrders[index];
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
                      leading: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: primaryColor.withOpacity(0.1),
                        child: Icon(Icons.factory_outlined, color: primaryColor, size: 20.sp),
                      ),
                      title: Text(
                        order.name,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12.sp),
                      ),
                      subtitle: Text(
                        "${order.quantity} ${order.unit} • Status: ${order.status.name}",
                        style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 10.sp),
                      ),
                      trailing: Text(
                        "₹${order.totalPrice.toStringAsFixed(0)}",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    );
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
}