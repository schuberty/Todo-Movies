import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_movies/src/modules/home/pages/home_page.dart';
import 'package:todo_movies/src/modules/movies/domain/repositories/movie_repository_base.dart';
import 'package:todo_movies/src/modules/movies/pages/movie_page.dart';
import 'package:todo_movies/src/shared/arguments/movie_argument.dart';

import '../modules/movies/bloc/movies_bloc.dart';

class AppRouter {
  static Route<void>? onGenerateRoutes(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider<MoviesBloc>(
            create: (_) => MoviesBloc(context.read<MovieRepositoryBase>()),
            child: const HomePage(),
          ),
        );
      case '/movie':
        if (arguments is MovieArgument) {
          return _movieRoute(arguments);
        } else {
          throw Exception(
            'Invalid argument provided for \'/movie\' route, it requires a $MovieArgument but got a ${arguments.runtimeType}',
          );
        }
      default:
        return null;
    }
  }

  static Route _movieRoute(MovieArgument argument) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, _) {
          return BlocProvider<MoviesBloc>(
            create: (_) => MoviesBloc(context.read<MovieRepositoryBase>()),
            child: MoviesPage(movie: argument.movie),
          );
        },
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: slideAnimation(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 500));
  }

  static Animation<Offset> slideAnimation(
    Animation<double> animation, {
    Offset begin = const Offset(1.0, 0.0),
  }) {
    const end = Offset.zero;
    final curve = CurveTween(curve: Curves.easeInSine);
    final tween = Tween(begin: begin, end: end).chain(curve);
    final slideAnimation = animation.drive(tween);

    return slideAnimation;
  }
}
