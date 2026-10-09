import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../features/consumer/views/Consumer_Dashboard.dart';
import '../../features/farmer/views/Farmer_Dashboard.dart';
import '../../features/fpo/views/screens/FPO_dashboard.dart';
import '../../features/processor/views/Processor_Dashboard.dart';
import '../../features/shg/views/SHG_Dashboard.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? SigninNavigation(String email,String Password,BuildContext context){
  if(email.contains("consumer")){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ConsumerDashboard(),));
  }
  else if(email.contains("farmer")){
    Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerDashboard(),));
  }
  else if(email.contains("fpo")){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>FpoDashboard(),));
  }
  else if(email.contains("processor")){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProcessorDashboard(),));
  }
  else if(email.contains("shg")){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>ShgDashboard(),));
  }
  else{
    ScaffoldMessenger.of(context).clearSnackBars();
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