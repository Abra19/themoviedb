class Endpoints {
  static const String getNewToken = '/authentication/token/new';
  static const String validateToken =
      '/authentication/token/validate_with_login';
  static const String getSession = '/authentication/session/new';

  static const String getPopularMovies = '/movie/popular';
  static const String searchMovies = '/search/movie';
  static String getMovieDetails(int movieId) => '/movie/$movieId';
  static String isMovieInFavorite(int movieId) =>
      '/movie/$movieId/account_states';

  static const String getPopularTVShows = '/tv/popular';
  static const String searchTVShows = '/search/tv';
  static String getTVShowDetails(int showId) => '/tv/$showId';
  static String isTVShowInFavorite(int showId) => '/tv/$showId/account_states';

  static String showActor(int actorId) => '/person/$actorId';

  static String getAllInTrend(String trendPeriod) =>
      '/trending/all/$trendPeriod';

  static const String getMoviesUpcoming = '/movie/upcoming';
  static const String getShowsUpcoming = '/tv/on_the_air';

  static const String getPlayingMovies = '/movie/now_playing';
  static const String getPlayingTVShows = '/tv/airing_today';

  static String postInFavorite(String? accountId) =>
      '/account/$accountId/favorite';
  static String getFavoriteMovies(String? accountId) =>
      '/account/$accountId/favorite/movies';
  static String getFavoriteTVShows(String? accountId) =>
      '/account/$accountId/favorite/tv';
}
