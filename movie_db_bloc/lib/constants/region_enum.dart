enum RegionType { ru, eu, us }

extension RegionTypeAsString on RegionType {
  String asString() {
    switch (this) {
      case RegionType.ru:
        return 'RU';
      case RegionType.eu:
        return 'FR';
      case RegionType.us:
        return 'US';
    }
  }
}
