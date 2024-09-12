import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import 'package:the_movie_db/ui/widgets/news_screen/news_screen_model.dart';
import 'package:the_movie_db/ui/widgets/news_screen/news_screen_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_details/tv_details_model.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_details/tv_details_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_screen/tv_shows_model.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_screen/tv_shows_widget.dart';

class ScreenFactories {
  Provider<LoaderViewModel> makeLoader() => Provider<LoaderViewModel>(
        create: (BuildContext context) => LoaderViewModel(context),
        lazy: false,
        child: const LoaderWidget(),
      );

  ChangeNotifierProvider<AuthViewModel> makeAuth() =>
      ChangeNotifierProvider<AuthViewModel>(
        create: (_) => AuthViewModel(),
        child: const AuthWidget(),
      );

  ChangeNotifierProvider<MainScreenViewModel> makeMainScreen() =>
      ChangeNotifierProvider<MainScreenViewModel>(
        create: (_) => MainScreenViewModel(),
        child: const MainScreenWidget(),
      );

  ChangeNotifierProvider<NewsScreenViewModel> makeNewsScreen() =>
      ChangeNotifierProvider<NewsScreenViewModel>(
        create: (_) => NewsScreenViewModel(),
        child: const NewsScreenWidget(),
      );

  ChangeNotifierProvider<MoviesViewModel> makeMoviesList() =>
      ChangeNotifierProvider<MoviesViewModel>(
        create: (_) => MoviesViewModel(),
        child: const MoviesWidget(),
      );

  ChangeNotifierProvider<TVShowsViewModel> makeTVList() =>
      ChangeNotifierProvider<TVShowsViewModel>(
        create: (_) => TVShowsViewModel(),
        child: const TVShowsWidget(),
      );

  ChangeNotifierProvider<MovieDetailsViewModel> makeMovieDetails(int movieId) {
    return ChangeNotifierProvider<MovieDetailsViewModel>(
      create: (_) => MovieDetailsViewModel(movieId),
      child: const MovieDetailsWidget(),
    );
  }

  ChangeNotifierProvider<ActorDetailsViewModel> makeActorDetails(int actorId) {
    return ChangeNotifierProvider<ActorDetailsViewModel>(
      create: (_) => ActorDetailsViewModel(actorId),
      child: const ActorDetailsWidget(),
    );
  }

  ChangeNotifierProvider<TVDetailsViewModel> makeTVDetails(int seriesId) {
    return ChangeNotifierProvider<TVDetailsViewModel>(
      create: (_) => TVDetailsViewModel(seriesId),
      child: const TVDetailsWidget(),
    );
  }

  ChangeNotifierProvider<FavoriteViewModel> makeFavoritesList() {
    return ChangeNotifierProvider<FavoriteViewModel>(
      create: (_) => FavoriteViewModel(),
      child: const FavoriteWidget(),
    );
  }

  MovieTrailer makeTrailer(String trailerKey) =>
      MovieTrailer(trailerKey: trailerKey);
}
