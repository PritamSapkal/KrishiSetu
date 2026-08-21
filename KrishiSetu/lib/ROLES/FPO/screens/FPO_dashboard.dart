import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishisetu/ROLES/FPO/screens/producescreen.dart';

import '../../../Provider/IndexHandlingProvider.dart';
import 'farmersscreen.dart';
import 'homescreen.dart';
import 'morescreen.dart';
import 'ordersscren.dart';

class FpoDashboard extends ConsumerStatefulWidget {
  @override
  ConsumerState<FpoDashboard> createState() => _FpoDashboardState();
}

class _FpoDashboardState extends ConsumerState<FpoDashboard> {
  @override
  Widget build(BuildContext context) {
    int bottomappbarindex = ref.watch(BottomAppbarIndexProvider);
    List<String> appbartitlelist=["KrishiSetu","My Produce","Orders","Farmers","Setting"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff964900),
        foregroundColor: Colors.white,
        title: Text(appbartitlelist[bottomappbarindex], style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 15.sp,),
        ),
        // Notification icon
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_sharp),
          ),
        ],
      ),

      body: [
        Homescreen(),
        Producescreen(),
        Ordersscren(),
        Farmersscreen(),
        Morescreen(),
      ][bottomappbarindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomappbarindex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          ref.read(BottomAppbarIndexProvider.notifier).update((state)=>index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled),label:"Home"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.tractor),label:"Produce" ),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),label:"Orders" ),
          BottomNavigationBarItem(icon: Icon(Icons.people_alt_outlined),label:"Farmers" ),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz_rounded),label:"more" ),
        ],
        selectedItemColor: const Color(0xff964900),     // Explicitly set text & icon active color
        unselectedItemColor: const Color(0xff595F6B),
        selectedIconTheme: IconThemeData(size: 23.sp,),
        selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 10.sp),
        unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 8.sp),
        elevation: 0.1,
        backgroundColor: Color(0xffF8F9FA),
      ),
    );
  }
}
