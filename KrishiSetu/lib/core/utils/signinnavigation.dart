import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../features/consumer/views/Consumer_Dashboard.dart';
import '../../features/farmer/views/Farmer_Dashboard.dart';
import '../../features/fpo/views/screens/FPO_dashboard.dart';
import '../../features/processor/views/Processor_Dashboard.dart';
import '../../features/shg/views/SHG_Dashboard.dart';

SigninNavigation(String role,BuildContext context){
  if(role.toLowerCase().contains("buyer")){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ConsumerDashboard(),));
  }
  else if(role.toLowerCase().contains("farmer")){
    Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerDashboard(),));
  }
  else if(role.contains("fpo")){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>FpoDashboard(),));
  }
  else if(role.toLowerCase().contains("processor")){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProcessorDashboard(),));
  }
  else if(role.toLowerCase().contains("shg")){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>ShgDashboard(),));
  }
  return null;
}