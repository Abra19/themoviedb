// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class FavoriteListEvents {}

class FavoriteMoviesLoadNextPage extends FavoriteListEvents {
  FavoriteMoviesLoadNextPage({required this.locale});

  final String locale;
}

class FavoriteShowsLoadNextPage extends FavoriteListEvents {
  FavoriteShowsLoadNextPage({required this.locale});

  final String locale;
}

class FavoritesListReset extends FavoriteListEvents {}
