import 'package:flutter/material.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
import 'package:the_movie_db/library/providers/provider.dart';
import 'package:the_movie_db/ui/widgets/favorites/favorite_widget.dart';
import 'package:the_movie_db/ui/widgets/main_app/main_app_model.dart';
import 'package:the_movie_db/ui/widgets/movie_screen/movies_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_screen/movies_widget_model.dart';
import 'package:the_movie_db/ui/widgets/news_screen/news_screen_model.dart';
import 'package:the_movie_db/ui/widgets/news_screen/news_screen_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_screen/tv_shows_model.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_screen/tv_shows_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedIndex = 0;
  final MoviesWidgetModel moviesModel = MoviesWidgetModel();
  final TVShowsModel showsModel = TVShowsModel();
  final NewsScreenModel newsModel = NewsScreenModel();

  void onSelectIndex(int index) {
    moviesModel.resetList;
    if (_selectedIndex == index) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    moviesModel.setupLocale(context);
    showsModel.setupLocale(context);
    newsModel.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final MainAppModel? appModel = Provider.read<MainAppModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: moviesModel.onRetryClick,
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () => appModel?.resetSession(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          NotifyProvider<NewsScreenModel>(
            create: () => newsModel,
            child: const NewsScreenWidget(),
          ),
          NotifyProvider<MoviesWidgetModel>(
            create: () => moviesModel,
            child: const MoviesWidget(),
          ),
          NotifyProvider<TVShowsModel>(
            create: () => showsModel,
            child: const TVShowsWidget(),
          ),
          NotifyProvider<MoviesWidgetModel>(
            create: () => moviesModel,
            child: const FavoriteWidget(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: onSelectIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'TV Shows',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
