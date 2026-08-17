import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishisetu/ROLES/FARMER/screens/Farmer_Dashboard.dart';
import 'package:krishisetu/ROLES/FPO/screens/FPO_dashboard.dart';
import 'package:krishisetu/ROLES/PROCESSOR/screens/Processor_Dashboard.dart';
import 'package:krishisetu/ROLES/SHG/screens/SHG_Dashboard.dart';

import '../ROLES/CONSUMER/screens/Consumer_Dashboard.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? SigninNavigation(String email,String Password,BuildContext context){
  if(email=="consumer@gmail.com"){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ConsumerDashboard(),));
  }
  else if(email=="farmer@gmail.com"){
    Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerDashboard(),));
  }
  else if(email=="fpo@gmail.com"){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>FpoDashboard(),));
  }
  else if(email=="processor@gmail.com"){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProcessorDashboard(),));
  }
  else if(email=="shg@gmail.com"){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>ShgDashboard(),));
  }
  else{
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Invalid Credentials",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.black87,
        duration: const Duration(seconds: 2),
      ),
    );
  }
  return null;
}