import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/domain/factories/screen_factories.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_view_cubit.dart';

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

  @override
  Widget build(BuildContext context) {
    final AuthViewCubit cubit = context.watch<AuthViewCubit>();

    final List<Widget> screens = <Widget>[
      _screenFactory.makeNewsScreen(),
      _screenFactory.makeMoviesList(),
      _screenFactory.makeTVList(),
      _screenFactory.makeFavoritesList(),
    ];

    void onLogout(BuildContext context, AuthCubitState state) {
      if (context.mounted && state is AuthCubitStateInitAuth) {
        MainNavigation.resetNavigation(context);
      }
    }

    return BlocListener<AuthViewCubit, AuthCubitState>(
      listener: onLogout,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TMDB'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: cubit.onLogoutPressed,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: screens,
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
      ),
    );
  }
}
