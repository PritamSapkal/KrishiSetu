import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodels/cart_riverpod.dart';
import '../viewmodels/consumer_bottom_index_provider.dart';

// Screens will be wired here
import 'MarketplaceScreen.dart';
import 'CartScreen.dart';
import 'BuyerOrdersScreen.dart';
import 'BuyerProfileScreen.dart';

class BuyerDashboard extends ConsumerStatefulWidget {
  const BuyerDashboard({super.key});

  @override
  ConsumerState<BuyerDashboard> createState() => _ConsumerDashboardState();
}

class _ConsumerDashboardState extends ConsumerState<BuyerDashboard> {
  static const Color primaryColor = Color(0xff004D40); // Deep Emerald Teal
  static const Color scaffoldBg = Color(0xffF8F9FA);

  final List<String> _appBarTitles = [
    "KrishiSetu Marketplace",
    "My Shopping Cart",
    "My Orders",
    "My Profile",
  ];

  @override
  Widget build(BuildContext context) {
    final int currentIndex = ref.watch(consumerBottomIndexProvider);
    final int cartItemsCount = ref.watch(cartItemsCountProvider);

    return PopScope(
      canPop: currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        // Redirect back to Marketplace (tab 0) if not on Home
        if (currentIndex != 0) {
          ref.read(consumerBottomIndexProvider.notifier).update((state) => 0);
        }
      },
      child: Scaffold(
        backgroundColor: scaffoldBg,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          foregroundColor: Colors.white,
          title: Text(
            _appBarTitles[currentIndex],
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          actions: [
            // Quick Cart shortcut icon on Top Bar (if not on Cart tab)
            if (currentIndex != 1)
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: IconButton(
                  onPressed: () {
                    ref.read(consumerBottomIndexProvider.notifier).update((state) => 1);
                  },
                  icon: Badge(
                    isLabelVisible: cartItemsCount > 0,
                    label: Text(
                      "$cartItemsCount",
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: const Color(0xffD84315), // Warm Terracotta Badge
                    child: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),

        // IndexedStack preserves scroll position across all 4 tabs
        body: IndexedStack(
          index: currentIndex,
          children: const [
            MarketplaceScreen(),
            CartScreen(),
            BuyerOrdersScreen(),
            BuyerProfileScreen(),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            ref.read(consumerBottomIndexProvider.notifier).update((state) => index);
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined),
              activeIcon: Icon(Icons.storefront),
              label: "Marketplace",
            ),

            BottomNavigationBarItem(
              icon: Badge(
                isLabelVisible: cartItemsCount > 0,
                label: Text(
                  "$cartItemsCount",
                  style: GoogleFonts.poppins(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: const Color(0xffD84315),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
              activeIcon: Badge(
                isLabelVisible: cartItemsCount > 0,
                label: Text(
                  "$cartItemsCount",
                  style: GoogleFonts.poppins(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: const Color(0xffD84315),
                child: const Icon(Icons.shopping_bag),
              ),
              label: "Cart",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: "Orders",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
          selectedItemColor: primaryColor,
          unselectedItemColor: const Color(0xff595F6B),
          selectedIconTheme: IconThemeData(size: 22.sp),
          unselectedIconTheme: IconThemeData(size: 20.sp),
          selectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 10.sp,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 8.sp,
          ),
          elevation: 0.1,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}