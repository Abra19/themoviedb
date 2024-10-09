// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class MoviesListEvents {}

class MoviesListLoadNextPage extends MoviesListEvents {
  MoviesListLoadNextPage({required this.locale});

  final String locale;
}

class MoviesListSearch extends MoviesListEvents {
  MoviesListSearch({required this.query});
  final String query;
}

class MoviesListReset extends MoviesListEvents {}
