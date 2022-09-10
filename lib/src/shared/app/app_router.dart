import 'package:flutter/material.dart';
import 'package:todo_movies/src/shared/app/route/route_paths.dart';

class AppRouter {
  const AppRouter._();

  static Route<void>? onGenerateRoutes(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case '/':
        return RoutePaths.homePage();
      case '/movie':
        return RoutePaths.moviePage(arguments: arguments);
      default:
        return null;
    }
  }
}
