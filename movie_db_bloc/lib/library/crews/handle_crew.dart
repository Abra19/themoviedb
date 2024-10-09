import 'package:the_movie_db/constants/movies_datas.dart';
import 'package:the_movie_db/domain/server_entities/movie_details/movie_details_credits.dart';

List<CrewData> handleCrew(List<Crew> crew) => crew
    .where((Crew el) => specialtyMovies.contains(el.job))
    .map((Crew el) => CrewData(name: el.name, job: el.job))
    .fold(<String, List<String>>{},
        (Map<String, List<String>> acc, CrewData el) {
      acc[el.name] = acc[el.name] != null
          ? <String>[...acc[el.name]!, el.job]
          : <String>[el.job];
      return acc;
    })
    .entries
    .map(
      (MapEntry<String, List<String>> el) => CrewData(
        name: el.key,
        job: el.value.join(', '),
      ),
    )
    .toList();
