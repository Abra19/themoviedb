class DataStructure {
  DataStructure({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.percent,
    required this.date,
    required this.type,
  });

  final int id;
  final String? posterPath;
  final String? title;
  final double percent;
  final String date;
  final String? type;
}

class MovieListRowData {
  MovieListRowData({
    required this.id,
    required this.title,
    required this.name,
    required this.posterPath,
    required this.releaseDate,
    required this.firstAirDate,
    required this.overview,
  });

  final int id;
  final String? title;
  final String? name;
  final String? posterPath;
  final String? releaseDate;
  final String? firstAirDate;
  final String? overview;
}
