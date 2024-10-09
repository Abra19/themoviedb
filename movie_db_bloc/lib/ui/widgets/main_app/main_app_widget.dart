import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static final MainNavigation mainNavigation = MainNavigation();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Movie DB Flutter App',
      theme: ThemeData.new(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.appBackgroundColor,
          foregroundColor: AppColors.appTextColor,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.appBackgroundColor,
          selectedItemColor: AppColors.appTextColor,
          unselectedItemColor: AppColors.appInputBorderColor,
        ),
      ),
      // ignore: always_specify_types
      localizationsDelegates: const <LocalizationsDelegate>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('ru', 'RU'),
        Locale('en', 'US'),
      ],
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
