import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/domain/blocs/auth_bloc.dart';
import 'package:the_movie_db/domain/blocs/movies_list_bloc.dart';
import 'package:the_movie_db/domain/states/auth_state.dart';
import 'package:the_movie_db/domain/states/movies_state.dart';
import 'package:the_movie_db/ui/widgets/actor_details/actor_details_model.dart';
import 'package:the_movie_db/ui/widgets/actor_details/actor_details_widget.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_view_cubit.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_widget.dart';
import 'package:the_movie_db/ui/widgets/favorites/favorite_model.dart';
import 'package:the_movie_db/ui/widgets/favorites/favorite_widget.dart';
import 'package:the_movie_db/ui/widgets/loader_widget/loader_widget.dart';
import 'package:the_movie_db/ui/widgets/loader_widget/loader_view_cubit.dart';
import 'package:the_movie_db/ui/widgets/main_screen/main_screen_model.dart';
import 'package:the_movie_db/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_model.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_screen/movie_list_cubit.dart';
import 'package:the_movie_db/ui/widgets/movie_screen/movies_widget.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenFactories {
  AuthBloc? _authBloc;

  AuthBloc _getOrCreateAuthBloc() {
    return _authBloc ?? AuthBloc(AuthCheckState());
  }

  BlocProvider<LoaderViewCubit> makeLoader() {
    return BlocProvider<LoaderViewCubit>(
      create: (_) => LoaderViewCubit(
        authBlock: _getOrCreateAuthBloc(),
        initialState: LoaderStates.unknown,
      ),
      child: const LoaderWidget(),
    );
  }

  BlocProvider<AuthViewCubit> makeAuth() {
    return BlocProvider<AuthViewCubit>(
      create: (_) => AuthViewCubit(
        authBlock: _getOrCreateAuthBloc(),
        initialState: AuthCubitStateInitAuth(),
      ),
      child: const AuthWidget(),
    );
  }

  ChangeNotifierProvider<MainScreenViewModel> makeMainScreen() {
    // _authBloc?.close();
    // _authBloc = null;
    return ChangeNotifierProvider<MainScreenViewModel>(
      create: (_) => MainScreenViewModel(),
      child: const MainScreenWidget(),
    );
  }

  ChangeNotifierProvider<NewsScreenViewModel> makeNewsScreen() =>
      ChangeNotifierProvider<NewsScreenViewModel>.value(
        value: NewsScreenViewModel(),
        child: const NewsScreenWidget(),
      );

  MultiProvider makeTrendingMovies() => MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<NewsScreenViewModel>.value(
            value: NewsScreenViewModel(),
          ),
          ChangeNotifierProvider<TrendedViewModel>.value(
            value: TrendedViewModel(),
          ),
        ],
        child: const TrendedMoviesWidget(),
      );

  MultiProvider makeNewMovies() => MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<NewsScreenViewModel>.value(
            value: NewsScreenViewModel(),
          ),
          ChangeNotifierProvider<NewMoviesViewModel>.value(
            value: NewMoviesViewModel(),
          ),
        ],
        child: const NewMoviesWidget(),
      );

  MultiProvider makePlayingMovies() => MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<NewsScreenViewModel>.value(
            value: NewsScreenViewModel(),
          ),
          ChangeNotifierProvider<PlayingMoviesViewModel>.value(
            value: PlayingMoviesViewModel(),
          ),
        ],
        child: const PlayingMoviesWidget(),
      );

  BlocProvider<MovieListCubit> makeMoviesList() => BlocProvider<MovieListCubit>(
        create: (_) => MovieListCubit(
          movieBloc: MoviesListBloc(MoviesListState.init()),
        ),
        child: const MoviesWidget(),
      );

  ChangeNotifierProvider<TVShowsViewModel> makeTVList() =>
      ChangeNotifierProvider<TVShowsViewModel>.value(
        value: TVShowsViewModel(),
        child: const TVShowsWidget(),
      );

  MultiProvider makeMovieDetails(int movieId) => MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<MovieDetailsViewModel>.value(
            value: MovieDetailsViewModel(movieId),
          ),
          ChangeNotifierProvider<MainScreenViewModel>.value(
            value: MainScreenViewModel(),
          ),
        ],
        child: const MovieDetailsWidget(),
      );

  MultiProvider makeTVDetails(int seriesId) => MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<TVDetailsViewModel>.value(
            value: TVDetailsViewModel(seriesId),
          ),
          ChangeNotifierProvider<MainScreenViewModel>.value(
            value: MainScreenViewModel(),
          ),
        ],
        child: const TVDetailsWidget(),
      );

  ChangeNotifierProvider<ActorDetailsViewModel> makeActorDetails(int actorId) =>
      ChangeNotifierProvider<ActorDetailsViewModel>.value(
        value: ActorDetailsViewModel(actorId),
        child: const ActorDetailsWidget(),
      );

  ChangeNotifierProvider<FavoriteViewModel> makeFavoritesList() =>
      ChangeNotifierProvider<FavoriteViewModel>.value(
        value: FavoriteViewModel(),
        child: const FavoriteWidget(),
      );

  MovieTrailer makeTrailer(String trailerKey) =>
      MovieTrailer(trailerKey: trailerKey);
}
