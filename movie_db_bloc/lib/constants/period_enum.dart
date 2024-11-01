enum PeriodType { day, week }

extension PeriodTypeAsString on PeriodType {
  String asString() {
    switch (this) {
      case PeriodType.day:
        return 'day';
      case PeriodType.week:
        return 'week';
    }
  }
}
