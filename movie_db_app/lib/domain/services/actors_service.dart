import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/server_entities/actors/actor_details.dart';

abstract class ActorsService {
  Future<ActorDetails> loadActorDetails(int actorId, String localeTag);
}

class ActorsServiceBasic implements ActorsService {
  const ActorsServiceBasic({required this.apiClient});

  final ApiClientFactory apiClient;

  @override
  Future<ActorDetails> loadActorDetails(int actorId, String localeTag) {
    return apiClient.showActor(actorId, localeTag);
  }
}
