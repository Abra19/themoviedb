import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/domain/blocs/auth_bloc.dart';
import 'package:the_movie_db/domain/blocs/favorite_lists_bloc.dart';
import 'package:the_movie_db/domain/blocs/movies_list_bloc.dart';
import 'package:the_movie_db/domain/blocs/new_movies_bloc.dart';
import 'package:the_movie_db/domain/blocs/playing_bloc.dart';
import 'package:the_movie_db/domain/blocs/shows_list_bloc.dart';
import 'package:the_movie_db/domain/blocs/trended_bloc.dart';
import 'package:the_movie_db/domain/states/auth_state.dart';
import 'package:the_movie_db/domain/states/favorites_state.dart';
import 'package:the_movie_db/domain/states/movies_state.dart';
import 'package:the_movie_db/domain/states/new_movies_state.dart';
import 'package:the_movie_db/domain/states/playing_state.dart';
import 'package:the_movie_db/domain/states/shows_state.dart';
import 'package:the_movie_db/domain/states/trended_state.dart';
import 'package:the_movie_db/ui/widgets/actor_details/actor_details_model.dart';
import 'package:the_movie_db/ui/widgets/actor_details/actor_details_widget.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_view_cubit.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_widget.dart';
import 'package:the_movie_db/ui/widgets/favorites/favorite_list_cubit.dart';
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
import 'package:the_movie_db/ui/widgets/news_screen/new_movies/new_movies_list_cubit.dart';
import 'package:the_movie_db/ui/widgets/news_screen/new_movies/new_movies_widget.dart';
import 'package:the_movie_db/ui/widgets/news_screen/news_screen_widget.dart';
import 'package:the_movie_db/ui/widgets/news_screen/playing_movies/playing_list_cubit.dart';
import 'package:the_movie_db/ui/widgets/news_screen/playing_movies/playing_movies_widget.dart';
import 'package:the_movie_db/ui/widgets/news_screen/trended_movies/trended_list_cubit.dart';
import 'package:the_movie_db/ui/widgets/news_screen/trended_movies/trended_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_details/tv_details_model.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_details/tv_details_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_screen/tv_shows_list_cubit.dart';
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

  BlocProvider<AuthViewCubit> makeMainScreen() {
    return BlocProvider<AuthViewCubit>(
      create: (_) => AuthViewCubit(
        authBlock: _getOrCreateAuthBloc(),
        initialState: AuthCubitStateInitAuth(),
      ),
      child: const MainScreenWidget(),
    );
  }

  NewsScreenWidget makeNewsScreen() => const NewsScreenWidget();

  BlocProvider<TrendedListCubit> makeTrendingMovies() =>
      BlocProvider<TrendedListCubit>(
        create: (_) => TrendedListCubit(
          trendedListsBloc: TrendedListBloc(TrendedListsState.init()),
        ),
        child: const TrendedMoviesWidget(),
      );

  BlocProvider<NewMoviesListCubit> makeNewMovies() =>
      BlocProvider<NewMoviesListCubit>(
        create: (_) => NewMoviesListCubit(
          newMoviesListsBloc: NewMoviesListBloc(NewMoviesListsState.init()),
        ),
        child: const NewMoviesWidget(),
      );

  BlocProvider<PlayingListCubit> makePlayingMovies() =>
      BlocProvider<PlayingListCubit>(
        create: (_) => PlayingListCubit(
          playingListsBloc: PlayingListBloc(PlayingListsState.init()),
        ),
        child: const PlayingMoviesWidget(),
      );

  BlocProvider<MovieListCubit> makeMoviesList() => BlocProvider<MovieListCubit>(
        create: (_) => MovieListCubit(
          movieBloc: MoviesListBloc(MoviesListState.init()),
        ),
        child: const MoviesWidget(),
      );

  BlocProvider<ShowListCubit> makeTVList() => BlocProvider<ShowListCubit>(
        create: (_) => ShowListCubit(
          showBloc: ShowsListBloc(ShowsListState.init()),
        ),
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

  BlocProvider<FavoriteListCubit> makeFavoritesList() =>
      BlocProvider<FavoriteListCubit>(
        create: (_) => FavoriteListCubit(
          favoritesBloc: FavoriteListsBloc(FavoriteListsState.init()),
        ),
        child: const FavoriteWidget(),
      );

  MovieTrailer makeTrailer(String trailerKey) =>
      MovieTrailer(trailerKey: trailerKey);
}
