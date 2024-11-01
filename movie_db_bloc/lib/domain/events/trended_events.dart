abstract class TrendedListEvents {}

class TrendedMoviesLoad extends TrendedListEvents {
  TrendedMoviesLoad({required this.locale});

  final String locale;
}

class TrendedListReset extends TrendedListEvents {}

class TrendedPeriodChange extends TrendedListEvents {
  TrendedPeriodChange({required this.period});

  final String period;
}
