import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/data_providers/local_storage.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/exceptions/handle_errors.dart';
import 'package:the_movie_db/domain/server_entities/actors/actor_details.dart';
import 'package:the_movie_db/domain/services/actors_service.dart';
import 'package:the_movie_db/library/dates/handle_dates.dart';
import 'package:the_movie_db/types/types.dart';

class ActorDetailsViewModel extends ChangeNotifier {
  ActorDetailsViewModel(this.actorId, this.actorService);

  final int actorId;

  final ActorsService actorService;

  final LocalStorage _localeStorage = LocalStorage();
  late DateFormat _dateFormat;

  ActorDatas data = ActorDatas();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String makeStringFromDate(DateTime? date) {
    return stringFromDate(date, _dateFormat);
  }

  Future<void> setupLocale(Locale locale) async {
    final bool updateLocale = _localeStorage.updateLocale(locale);
    if (!updateLocale) {
      return;
    }
    _dateFormat = DateFormat.yMMMMd(_localeStorage.localeTag);
    await loadActorDetails(actorId);
  }

  void updateData(ActorDetails? details) {
    data.isLoading = details == null;
    if (details != null) {
      data.name = details.name ?? 'Loading ...';
      data.biography = details.biography ?? '';
      data.birthday =
          details.birthday != null ? makeStringFromDate(details.birthday) : '';
      data.deathday =
          details.deathday != null ? makeStringFromDate(details.deathday) : '';
      data.placeOfBirth = details.placeOfBirth ?? '';
      data.profilePath = details.profilePath;
    }
    notifyListeners();
  }

  Future<void> loadActorDetails(int actorId) async {
    try {
      final ActorDetails actorDetails = await actorService.loadActorDetails(
        actorId,
        _localeStorage.localeTag,
      );
      updateData(actorDetails);
    } on ApiClientException catch (error) {
      handleErrors(error);
    } catch (e) {
      _errorMessage = 'Unexpected error, try again later';
    } finally {
      notifyListeners();
    }
  }
}
