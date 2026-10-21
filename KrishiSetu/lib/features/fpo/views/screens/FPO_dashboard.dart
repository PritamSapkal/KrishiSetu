import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishisetu/features/fpo/views/screens/producescreen.dart';
import '../../viewmodels/FPOBottomAppbarIndexRiverpod.dart';
import 'farmersscreen.dart';
import 'homescreen.dart';
import 'ProfileScreen.dart';
import 'ordersscren.dart';

class FpoDashboard extends ConsumerStatefulWidget {
  const FpoDashboard({super.key});

  @override
  ConsumerState<FpoDashboard> createState() => _FpoDashboardState();
}

class _FpoDashboardState extends ConsumerState<FpoDashboard> {
  final List<String> appbartitlelist = [
    "KrishiSetu",
    "My Produce",
    "Orders",
    "Farmers",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    final int bottomappbarindex = ref.watch(FpoBottomAppbarindexProvider);

    return PopScope(
      // canPop is true ONLY when the user is already on the Home tab (index 0)
      canPop: bottomappbarindex == 0,
      onPopInvokedWithResult: (didPop, result) {
        // If the route was already popped, do nothing
        if (didPop) return;

        // If on any tab other than Home, redirect to Home (index 0)
        if (bottomappbarindex != 0) {
          ref.read(FpoBottomAppbarindexProvider.notifier).update((state) => 0);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff964900),
          foregroundColor: Colors.white,
          title: Text(
            appbartitlelist[bottomappbarindex],
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
          // Notification icon
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_sharp),
            ),
          ],
        ),

        // IndexedStack preserves the scroll position and state of each tab
        body: IndexedStack(
          index: bottomappbarindex,
          children: [
            Homescreen(),
            const Producescreen(),
            const Ordersscren(),
            Farmersscreen(),
            const Profilescreen(),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomappbarindex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            ref.read(FpoBottomAppbarindexProvider.notifier).update((state) => index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.tractor),
              label: "Produce",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined),
              label: "Farmers",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: "Profile",
            ),
          ],
          selectedItemColor: const Color(0xff964900),
          unselectedItemColor: const Color(0xff595F6B),
          selectedIconTheme: IconThemeData(size: 23.sp),
          selectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 10.sp,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 8.sp,
          ),
          elevation: 0.1,
          backgroundColor: const Color(0xffF8F9FA),
        ),
      ),
    );
  }
}