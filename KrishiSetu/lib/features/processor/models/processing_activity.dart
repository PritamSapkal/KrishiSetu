import 'package:flutter/material.dart';

enum ProcessingActivity {
  CLEANING,
  GRADING,
  DEHULLING,
  MILLING,
  FLOUR_PRODUCTION,
  PACKAGING,
  MILLET_PRODUCT_MANUFACTURING,
  OTHER;

  /// Parse String from Backend JSON into Enum safely
  static ProcessingActivity fromString(String? value) {
    return ProcessingActivity.values.firstWhere(
          (e) => e.name.toUpperCase() == (value ?? '').trim().toUpperCase(),
      orElse: () => ProcessingActivity.OTHER,
    );
  }

  /// Clean user-friendly display text for Chips & Dropdowns
  String get displayName {
    switch (this) {
      case ProcessingActivity.CLEANING:
        return "Grain Cleaning";
      case ProcessingActivity.GRADING:
        return "Grading & Sorting";
      case ProcessingActivity.DEHULLING:
        return "Dehulling";
      case ProcessingActivity.MILLING:
        return "Milling";
      case ProcessingActivity.FLOUR_PRODUCTION:
        return "Flour Production";
      case ProcessingActivity.PACKAGING:
        return "Packaging & Bagging";
      case ProcessingActivity.MILLET_PRODUCT_MANUFACTURING:
        return "Millet Product Manufacturing";
      case ProcessingActivity.OTHER:
        return "Other Activity";
    }
  }

  /// Relevant icon for Processor capability badges
  IconData get icon {
    switch (this) {
      case ProcessingActivity.CLEANING:
        return Icons.cleaning_services_outlined;
      case ProcessingActivity.GRADING:
        return Icons.tune_outlined;
      case ProcessingActivity.DEHULLING:
        return Icons.grain_outlined;
      case ProcessingActivity.MILLING:
        return Icons.precision_manufacturing_outlined;
      case ProcessingActivity.FLOUR_PRODUCTION:
        return Icons.bakery_dining_outlined;
      case ProcessingActivity.PACKAGING:
        return Icons.inventory_2_outlined;
      case ProcessingActivity.MILLET_PRODUCT_MANUFACTURING:
        return Icons.factory_outlined;
      case ProcessingActivity.OTHER:
        return Icons.more_horiz_rounded;
    }
  }
}