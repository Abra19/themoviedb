import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details_video.dart';
import 'package:the_movie_db/domain/entities/show_details/show_details.dart';
import 'package:the_movie_db/library/dates/date_string_from_date.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class TVDetailsViewModel extends ChangeNotifier {
  TVDetailsViewModel(this.showId);

  final SessionDataProvider sessionProvider = SessionDataProvider();
  final ApiClient _apiClient = ApiClient();
  final int showId;

  String _locale = '';
  late DateFormat _dateFormat;

  ShowDetails? _showDetails;
  ShowDetails? get showDetails => _showDetails;

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  String? _trailerKey;
  String? get trailerKey => _trailerKey;

  // String stringFromDate(DateTime? date) =>
  //     dateStringFromDate(_dateFormat, date);

  Future<void> setupLocale(BuildContext context) async {
    final String locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) {
      return;
    }
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(_locale);
    await loadShowDetails(showId);
  }

  Future<void> loadShowDetails(int showId) async {
    _showDetails = await _apiClient.getShowDetails(showId, _locale);
    _trailerKey = getTrailerKey(_showDetails);
    final String? token = await sessionProvider.getSessionId();
    if (token != null) {
      final String result = await _apiClient.isShowInFavorites(showId, token);
      _isFavorite = result == 'true';
    }

    notifyListeners();
  }

  void onActorClick(BuildContext context, int id) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetailsActor,
      arguments: id,
    );
  }

  String? getTrailerKey(ShowDetails? showDetails) {
    final List<MovieDetailVideoResult>? results = showDetails?.videos.results;

    if (results == null) {
      return null;
    }

    final List<MovieDetailVideoResult> videos = results
        .where(
          (MovieDetailVideoResult video) =>
              video.type == 'Trailer' && video.site == 'YouTube',
        )
        .toList();
    return videos.isNotEmpty ? videos.first.key : null;
  }

  void showTrailer(BuildContext context) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetailsTrailer,
      arguments: _trailerKey,
    );
  }

  Future<void> onFavoriteClick(BuildContext context) async {
    final String? token = await sessionProvider.getSessionId();
    if (token == null) {
      return;
    }
    await _apiClient.postInFavorites(
      mediaType: MediaType.tv,
      mediaId: showId,
      isFavorite: !_isFavorite,
      token: token,
    );

    _isFavorite = !_isFavorite;

    notifyListeners();
  }
}
