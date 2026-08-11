import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../EntryScreens/RegistrationScreens/ConsumerRegistration.dart';
import '../EntryScreens/RegistrationScreens/FPORegistration.dart';
import '../EntryScreens/RegistrationScreens/FarmerRegistration.dart';
import '../EntryScreens/RegistrationScreens/ProcessorRegistration.dart';
import '../EntryScreens/RegistrationScreens/SHGRegistration.dart';

final List<Map<String, dynamic>> rolesList = [
  {
    "title": "Consumer",
    "description": "Buy fresh, traceable millet and farm products directly from verified growers and processors.",
    "icon": FontAwesomeIcons.basketShopping,
    "color": Colors.orange.shade700,
    "screen": Consumerregistration(),
  },
  {
    "title": "Farmer",
    "description": "Sell your crops at fair prices, connect with buyers, and manage your crop yields.",
    "icon": FontAwesomeIcons.wheatAwn,
    "color": Colors.green.shade700,
    "screen": Farmerregistration(),
  },
  {
    "title": "Processor",
    "description": "Source raw millets directly from farmers/FPOs, process them, and supply value-added goods.",
    "icon": FontAwesomeIcons.industry,
    "color": Colors.blue.shade700,
    "screen": Processorregistration(),
  },
  {
    "title": "FPO / Cooperative",
    "description": "Aggregate member farmer yields, command better market rates, and manage bulk trade operations.",
    "icon": FontAwesomeIcons.buildingNgo,
    "color": Colors.teal.shade700,
    "screen": Fporegistration(),
  },
  {
    "title": "Self Help Group (Bachat Gat)",
    "description": "Empower women entrepreneurs to showcase, market, and sell local processed food products.",
    "icon": FontAwesomeIcons.peopleGroup,
    "color": Colors.purple.shade700,
    "screen": Shgregistration(),
  },
];

