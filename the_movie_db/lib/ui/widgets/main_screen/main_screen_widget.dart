import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:the_movie_db/ui/widgets/movie_screen/movies_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_screen/movies_widget_model.dart';
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

  void onSelectIndex(int index) {
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
  }

  @override
  Widget build(BuildContext context) {
    Future<void> onLogout() async {
      SessionDataProvider().setSessionId(null);
      await Navigator.of(context)
          .pushReplacementNamed(MainNavigationRouteNames.auth);
    }

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
            onPressed: onLogout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          const Text('Index 0: News'),
          NotifyProvider<MoviesWidgetModel>(
            create: () => moviesModel,
            child: const MoviesWidget(),
          ),
          NotifyProvider<TVShowsModel>(
            create: () => showsModel,
            child: const TVShowsWidget(),
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
        ],
      ),
    );
  }
}
