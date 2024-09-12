import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/domain/api_client/endpoints.dart';
import 'package:the_movie_db/domain/api_client/network_client.dart';
import 'package:the_movie_db/domain/entities/actors/actor_details.dart';

class ActorApiClient {
  final NetworkClient _networkClient = NetworkClient();
  Future<ActorDetails> showActor(
    int actorId,
    String locale,
  ) async {
    ActorDetails parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return ActorDetails.fromJson(mapJson);
    }

    return _networkClient.getRequest<ActorDetails>(
      Config.host,
      Endpoints.showActor(actorId),
      parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'language': locale,
      },
    );
  }
}
