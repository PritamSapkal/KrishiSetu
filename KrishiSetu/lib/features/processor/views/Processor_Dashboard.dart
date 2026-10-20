import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodels/ProcessorBottomAppBarIndex.dart';
import 'ProcessorHomeScreen.dart';
import 'ProcessorOrderScreen.dart';
import 'ProcessorProductScreen.dart';
import 'ProcessorProfileScreen.dart';

class ProcessorDashboard extends ConsumerStatefulWidget {
  const ProcessorDashboard({super.key});

  @override
  ConsumerState<ProcessorDashboard> createState() => _ProcessorDashboardState();
}

class _ProcessorDashboardState extends ConsumerState<ProcessorDashboard> {
  final List<String> appbartitlelist = [
    "KrishiSetu",
    "Products",
    "Orders",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    final int bottomAppBarIndex = ref.watch(ProcessorBottomAppBarIndexProvider);

    return PopScope(
      canPop: bottomAppBarIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (bottomAppBarIndex != 0) {
          ref
              .read(ProcessorBottomAppBarIndexProvider.notifier)
              .update((state) => 0);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF8F9FA),
        appBar: AppBar(
          backgroundColor: const Color(0xff4A148C),
          foregroundColor: Colors.white,
          title: Text(
            appbartitlelist[bottomAppBarIndex],
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
        ),
        body: IndexedStack(
          index: bottomAppBarIndex,
          children: const [
            Processorhomescreen(),
            ProcessorProductScreen(),
            ProcessorOrderScreen(),
            ProcessorProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomAppBarIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            ref
                .read(ProcessorBottomAppBarIndexProvider.notifier)
                .update((state) => index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.boxesStacked),
              label: "Products",
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
          selectedItemColor: const Color(0xff4A148C),
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