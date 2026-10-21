enum MilletType {
  RAGI,
  JOWAR,
  BAJRA,
  KODO,
  LITTLE_MILLET,
  FOXTAIL,
  PROSO,
  BARNYARD;

  /// Parse from backend string safely
  static MilletType fromString(String? value) {
    return MilletType.values.firstWhere(
          (e) => e.name.toUpperCase() == (value ?? '').trim().toUpperCase(),
      orElse: () => MilletType.RAGI,
    );
  }

  /// Clean display name with regional context
  String get displayName {
    switch (this) {
      case MilletType.RAGI:
        return "Ragi (Finger Millet / नाचणी)";
      case MilletType.JOWAR:
        return "Jowar (Sorghum / ज्वारी)";
      case MilletType.BAJRA:
        return "Bajra (Pearl Millet / बाजरी)";
      case MilletType.KODO:
        return "Kodo Millet (कोडो)";
      case MilletType.LITTLE_MILLET:
        return "Little Millet (कुटकी / सावा)";
      case MilletType.FOXTAIL:
        return "Foxtail Millet (राळा / कांगणी)";
      case MilletType.PROSO:
        return "Proso Millet (वरी / चिन)";
      case MilletType.BARNYARD:
        return "Barnyard Millet (भगर / संवा)";
    }
  }

  /// Short name for filters/chips
  String get shortName {
    switch (this) {
      case MilletType.RAGI:
        return "Ragi";
      case MilletType.JOWAR:
        return "Jowar";
      case MilletType.BAJRA:
        return "Bajra";
      case MilletType.KODO:
        return "Kodo";
      case MilletType.LITTLE_MILLET:
        return "Little Millet";
      case MilletType.FOXTAIL:
        return "Foxtail";
      case MilletType.PROSO:
        return "Proso";
      case MilletType.BARNYARD:
        return "Barnyard";
    }
  }
}