import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/entry/views/SplashScreen.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    return runApp(ProviderScope(child: MyApp(),));
  });
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
       builder: (context, child) {
         return MaterialApp(
           debugShowCheckedModeBanner: false,
           home: Splashscreen(),

           theme: ThemeData.light().copyWith(

               splashColor: Colors.transparent,


               highlightColor: Colors.transparent,
             textTheme: TextTheme().copyWith(
               titleLarge: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize:50.sp),
               titleMedium: GoogleFonts.poppins(color: Colors.white),
               headlineLarge:GoogleFonts.robotoSlab(color: Colors.black),
               headlineSmall:GoogleFonts.robotoSlab(color: Colors.black),
             )
           ),
         );
       },
    );
  }
}