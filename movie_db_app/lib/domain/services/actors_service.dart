import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/server_entities/actors/actor_details.dart';

class ActorsService {
  final ApiClient _apiClient = ApiClient();

  Future<ActorDetails> loadActorDetails(int actorId, String localeTag) {
    return _apiClient.showActor(actorId, localeTag);
  }
}
