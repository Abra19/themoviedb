import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/domain/factories/screen_factories.dart';
import 'package:the_movie_db/ui/widgets/main_screen/main_screen_model.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedIndex = 0;
  final ScreenFactories _screenFactory = ScreenFactories();

  void onSelectIndex(int index) {
    if (_selectedIndex == index) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  void refreshPage() {
    setState(
        () {}); // to do - in model - in depend on index - resetList and errormessage null
  }

  @override
  Widget build(BuildContext context) {
    final MainScreenViewModel mainModel = context.read<MainScreenViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () => mainModel.onRefreshButtonPressed(_selectedIndex),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () => mainModel.onLogoutButtonPressed(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          _screenFactory.makeNewsScreen(),
          _screenFactory.makeMoviesList(),
          _screenFactory.makeTVList(),
          _screenFactory.makeFavoritesList(),
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
