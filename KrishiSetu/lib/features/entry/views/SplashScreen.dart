import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'OnbordingScreen.dart';

class Splashscreen extends StatefulWidget {
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Onbordingscreen(),));
    });
  }
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenheight,
        width: screenwidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff2E7D32), Color(0xff4CAF50)],
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // top right cornered faded circle.
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 150.w,
                height: 150.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.09),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(150.r),
                  ),
                ),
              ),
            ),
            // Middel part logo container & app Name
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Container
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30.sp),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.sp,
                            spreadRadius: 10.sp,
                          ),
                        ],
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.seedling,
                          color: Color(0xFFFFCC00),
                          size: 30.sp,
                        ),
                      ),
                    ),
                  ),
                  // KrishiSetu Title
                  Text(
                    "KrishiSetu",
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 48),
                    textAlign: TextAlign.center,
                  ),
                  // billing the millet ecosystem wit tech text
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 1, 8, 8),
                    child: Text(
                      "Bridging Millet Ecosystem with Tech",
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(
                            fontSize: 15.sp,
                            color: Colors.white.withOpacity(0.9),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //Farm to Fork · Farmer to Consumer · Tradition to Technology
                  Padding(
                    padding: const EdgeInsets.only(top: 60,bottom: 40),
                    child: Text("Farm to Fork · Farmer to Consumer · Tradition to Technology",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white.withOpacity(0.7),fontSize: 12.sp),textAlign:TextAlign.center,),
                  ),
                  // spinkit of 3 bounces
                  SpinKitThreeBounce(
                    color: Colors.white,
                    size: 20.sp,
                  ),

                   ],
              ),
            ),
            //bottom left corner faded circle.
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: 200.w,
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(200))
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
