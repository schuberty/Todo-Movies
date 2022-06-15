import 'package:flutter/material.dart';
import 'package:todo_movies/src/modules/movies/pages/movies_page.dart';

class AppRouter {
  static Route<void>? onGenerateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const MoviesPage(),
        );
      default:
        return null;
    }
  }
}
