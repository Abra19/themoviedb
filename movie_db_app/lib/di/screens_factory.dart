import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/di/di_container.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:the_movie_db/ui/widgets/actor_details/actor_details_model.dart';
import 'package:the_movie_db/ui/widgets/actor_details/actor_details_widget.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_model.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_widget.dart';
import 'package:the_movie_db/ui/widgets/favorites/favorite_model.dart';
import 'package:the_movie_db/ui/widgets/favorites/favorite_widget.dart';
import 'package:the_movie_db/ui/widgets/loader_widget/loader_widget.dart';
import 'package:the_movie_db/ui/widgets/loader_widget/loader_view_model.dart';
import 'package:the_movie_db/ui/widgets/main_screen/main_screen_model.dart';
import 'package:the_movie_db/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_model.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_screen/movies_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_screen/movies_model.dart';
import 'package:the_movie_db/ui/widgets/movie_trailer/movie_trailer.dart';
import 'package:the_movie_db/ui/widgets/news_screen/new_movies/new_movies_view_model.dart';
import 'package:the_movie_db/ui/widgets/news_screen/new_movies/new_movies_widget.dart';
import 'package:the_movie_db/ui/widgets/news_screen/news_screen_model.dart';
import 'package:the_movie_db/ui/widgets/news_screen/news_screen_widget.dart';
import 'package:the_movie_db/ui/widgets/news_screen/playing_movies/playing_movies_widget.dart';
import 'package:the_movie_db/ui/widgets/news_screen/playing_movies/playing_view_model.dart';
import 'package:the_movie_db/ui/widgets/news_screen/trended_movies/trended_view_model.dart';
import 'package:the_movie_db/ui/widgets/news_screen/trended_movies/trended_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_details/tv_details_model.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_details/tv_details_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_screen/tv_shows_model.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_screen/tv_shows_widget.dart';

class ScreensFactoryBasic implements ScreensFactory {
  const ScreensFactoryBasic({required this.diContainer});

  final DIContainer diContainer;

  @override
  Provider<LoaderViewModel> makeLoader() => Provider<LoaderViewModel>(
        create: (BuildContext context) => diContainer.makeLoader(context),
        lazy: false,
        child: const LoaderWidget(),
      );

  @override
  ChangeNotifierProvider<AuthViewModel> makeAuth() =>
      ChangeNotifierProvider<AuthViewModel>(
        create: (_) => diContainer.makeAuthViewModel(),
        child: const AuthWidget(),
      );

  @override
  ChangeNotifierProvider<MainScreenViewModel> makeMainScreen() =>
      ChangeNotifierProvider<MainScreenViewModel>(
        create: (_) => diContainer.makeMainScreenViewModel(),
        child: MainScreenWidget(screenFactory: this),
      );

  @override
  ChangeNotifierProvider<NewsScreenViewModel> makeNewsScreen() =>
      ChangeNotifierProvider<NewsScreenViewModel>(
        create: (_) => NewsScreenViewModel(),
        child: NewsScreenWidget(screensFactory: this),
      );

  @override
  MultiProvider makeTrendingMovies() => MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<NewsScreenViewModel>(
            create: (_) => NewsScreenViewModel(),
          ),
          ChangeNotifierProvider<TrendedViewModel>(
            create: (_) => diContainer.makeTrendedMovies(),
          ),
        ],
        child: const TrendedMoviesWidget(),
      );

  @override
  MultiProvider makeNewMovies() => MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<NewsScreenViewModel>(
            create: (_) => NewsScreenViewModel(),
          ),
          ChangeNotifierProvider<NewMoviesViewModel>(
            create: (_) => diContainer.makeNewMovies(),
          ),
        ],
        child: const NewMoviesWidget(),
      );

  @override
  MultiProvider makePlayingMovies() => MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<NewsScreenViewModel>(
            create: (_) => NewsScreenViewModel(),
          ),
          ChangeNotifierProvider<PlayingMoviesViewModel>(
            create: (_) => diContainer.makePlayingMovies(),
          ),
        ],
        child: const PlayingMoviesWidget(),
      );

  @override
  ChangeNotifierProvider<MoviesViewModel> makeMoviesList() =>
      ChangeNotifierProvider<MoviesViewModel>(
        create: (_) => diContainer.makeMoviesList(),
        child: const MoviesWidget(),
      );

  @override
  ChangeNotifierProvider<TVShowsViewModel> makeTVList() =>
      ChangeNotifierProvider<TVShowsViewModel>(
        create: (_) => diContainer.makeTVList(),
        child: const TVShowsWidget(),
      );

  @override
  MultiProvider makeMovieDetails(int movieId) => MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<MovieDetailsViewModel>(
            create: (_) => diContainer.makeMovieDetails(movieId),
          ),
          ChangeNotifierProvider<MainScreenViewModel>(
            create: (_) => diContainer.makeMainScreenViewModel(),
          ),
        ],
        child: const MovieDetailsWidget(),
      );

  @override
  MultiProvider makeTVDetails(int seriesId) => MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<TVDetailsViewModel>(
            create: (_) => diContainer.makeTVDetails(seriesId),
          ),
          ChangeNotifierProvider<MainScreenViewModel>(
            create: (_) => diContainer.makeMainScreenViewModel(),
          ),
        ],
        child: const TVDetailsWidget(),
      );

  @override
  ChangeNotifierProvider<ActorDetailsViewModel> makeActorDetails(int actorId) =>
      ChangeNotifierProvider<ActorDetailsViewModel>(
        create: (_) => diContainer.makeActorDetails(actorId),
        child: const ActorDetailsWidget(),
      );

  @override
  ChangeNotifierProvider<FavoriteViewModel> makeFavoritesList() =>
      ChangeNotifierProvider<FavoriteViewModel>(
        create: (_) => diContainer.makeFavoriteViewModel(),
        child: const FavoriteWidget(),
      );

  @override
  MovieTrailer makeTrailer(String trailerKey) =>
      MovieTrailer(trailerKey: trailerKey);
}













//   ChangeNotifierProvider<ActorDetailsViewModel> makeActorDetails(int actorId) =>
//       ChangeNotifierProvider<ActorDetailsViewModel>(
//         create: (_) => ActorDetailsViewModel(actorId),
//         child: const ActorDetailsWidget(),
//       );

//   ChangeNotifierProvider<FavoriteViewModel> makeFavoritesList() =>
//       ChangeNotifierProvider<FavoriteViewModel>(
//         create: (_) => FavoriteViewModel(),
//         child: const FavoriteWidget(),
//       );

//   MovieTrailer makeTrailer(String trailerKey) =>
//       MovieTrailer(trailerKey: trailerKey);
// }
