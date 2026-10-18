import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodels/BottomIndexRiverpod.dart';

class ShgDashboard extends ConsumerStatefulWidget{
  @override
  ConsumerState<ShgDashboard> createState() => _ShgDashboardState();
}

class _ShgDashboardState extends ConsumerState<ShgDashboard> {
  @override
  Widget build(BuildContext context) {
    Color Primarycolor=Color(0xff880D4F);
    Color backgrounColor=const Color(0xffF8F9FA);
    int _bottomappbarindex=ref.watch(BottomIndexProvider);
    return Scaffold(
      backgroundColor: backgrounColor,
      appBar: AppBar(
        backgroundColor:Color(0xff880D4F),
        foregroundColor: Colors.white,
        title: Text("SHG Dashboard!",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.sp),),
      ),
      body: Container(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomappbarindex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          ref.read(BottomIndexProvider.notifier).update((state) => index);
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.basketShopping),
            label: "Produce",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Orders",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: "Members",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: "Profile",
          ),
        ],
        selectedItemColor: Primarycolor,
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
        backgroundColor: backgrounColor,
      ),
    );
  }
}