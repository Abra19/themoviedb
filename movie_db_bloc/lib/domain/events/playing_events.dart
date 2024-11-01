abstract class PlayingListEvents {}

class PlayingMoviesLoad extends PlayingListEvents {
  PlayingMoviesLoad({required this.locale});

  final String locale;
}

class PlayingShowsLoad extends PlayingListEvents {
  PlayingShowsLoad({required this.locale});

  final String locale;
}

class PlayingListReset extends PlayingListEvents {}

class PlayingRegionChange extends PlayingListEvents {
  PlayingRegionChange({required this.region});

  final String region;
}
