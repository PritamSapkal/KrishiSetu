import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../viewmodels/bottomAppbarIndexProvider.dart';
import 'FarmerHomeScreen.dart';
import 'FarmerOrderScreen.dart';
import 'FarmerProduceScreen.dart';
import 'FarmerProfileScreen.dart';

class FarmerDashboard extends ConsumerStatefulWidget {
  const FarmerDashboard({super.key});

  @override
  ConsumerState<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends ConsumerState<FarmerDashboard> {
  final List<String> _appbartitlelist = [
    "KrishiSetu",
    "Produce",
    "Orders",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    final int bottomAppbarIndex = ref.watch(FarmerBottomAppbarIndexProvider);

    return PopScope(
      canPop: bottomAppbarIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (bottomAppbarIndex != 0) {
          ref
              .read(FarmerBottomAppbarIndexProvider.notifier)
              .update((state) => 0);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff2E7D32),
          foregroundColor: Colors.white,
          title: Text(
            _appbartitlelist[bottomAppbarIndex],
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
        ),
        body: IndexedStack(
          index: bottomAppbarIndex,
          children: const [
            FarmerHomeScreen(),
            FarmerProduceScreen(),
            FarmerOrderScreen(),
            FarmerProfileScreen(),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomAppbarIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            ref
                .read(FarmerBottomAppbarIndexProvider.notifier)
                .update((state) => index);
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
              icon: Icon(Icons.person_outline_rounded),
              label: "Profile",
            ),
          ],
          selectedItemColor: const Color(0xff2E7D32),
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