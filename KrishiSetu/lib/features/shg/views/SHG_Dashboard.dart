import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../viewmodels/BottomIndexRiverpod.dart';
import 'HomeScreen.dart';
import 'MemmberScreen.dart';
import 'OrderScreen.dart';
import 'ProduceScreen.dart';
import 'ProfileScreen.dart';

class ShgDashboard extends ConsumerStatefulWidget {
  const ShgDashboard({super.key});

  @override
  ConsumerState<ShgDashboard> createState() => _ShgDashboardState();
}

class _ShgDashboardState extends ConsumerState<ShgDashboard> {
  final List<String> _appbartitlelist = [
    "KrishiSetu",
    "Product",
    "Orders",
    "Members",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xff880D4F);
    const Color backgroundColor = Color(0xffF8F9FA);
    final int bottomAppBarIndex = ref.watch(ShgBottomIndexProvider);

    return PopScope(
      canPop: bottomAppBarIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (bottomAppBarIndex != 0) {
          ref.read(ShgBottomIndexProvider.notifier).update((state) => 0);
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          title: Text(
            _appbartitlelist[bottomAppBarIndex],
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
            ShgHomescreen(),
            SHGProducescreen(),
            SHGOrderScreen(),
            SHGMemmberscreen(),
            SHGProfilescreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomAppBarIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            ref.read(ShgBottomIndexProvider.notifier).update((state) => index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.basketShopping),
              label: "Product",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined),
              label: "Members",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: "Profile",
            ),
          ],
          selectedItemColor: primaryColor,
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
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}