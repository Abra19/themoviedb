import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entities/actors/actor_details.dart';

class ActorDetailsModel extends ChangeNotifier {
  ActorDetailsModel(this.actorId);

  final ApiClient _apiClient = ApiClient();
  final int actorId;

  String _locale = '';
  late DateFormat _dateFormat;

  ActorDetails? _actorDetails;
  ActorDetails? get actorDetails => _actorDetails;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async {
    final String locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) {
      return;
    }
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(_locale);
    await loadActorDetails(actorId);
  }

  Future<void> loadActorDetails(int actorId) async {
    _actorDetails = await _apiClient.showActor(actorId, _locale);
    notifyListeners();
  }
}
