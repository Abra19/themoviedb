abstract class NewMoviesListEvents {}

class NewMoviesLoad extends NewMoviesListEvents {
  NewMoviesLoad({required this.locale});

  final String locale;
}

class NewShowsLoad extends NewMoviesListEvents {
  NewShowsLoad({required this.locale});

  final String locale;
}

class NewMoviesListReset extends NewMoviesListEvents {}

class NewMoviesRegionChange extends NewMoviesListEvents {
  NewMoviesRegionChange({required this.region});

  final String region;
}
