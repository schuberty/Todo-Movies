import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_movies/src/modules/home/presentation/pages/home_page.dart';
import 'package:todo_movies/src/modules/movies/domain/repositories/movie_repository_base.dart';
import 'package:todo_movies/src/modules/movies/presentation/bloc/movies_bloc.dart';
import 'package:todo_movies/src/modules/movies/presentation/pages/movie_page.dart';
import 'package:todo_movies/src/shared/app/route/route_animator.dart';
import 'package:todo_movies/src/shared/app/route/route_arguments/movie_argument.dart';

class RoutePaths {
  RoutePaths._();

  static Route homePage() {
    final homeRoute = MaterialPageRoute(
      builder: (context) => BlocProvider<MoviesBloc>(
        create: (_) => MoviesBloc(context.read<MovieRepositoryBase>()),
        child: const HomePage(),
      ),
    );

    return homeRoute;
  }

  static Route moviePage({required Object? arguments}) {
    late final Route movieRoute;

    if (arguments is MovieArgument) {
      movieRoute = RouteAnimator.rightToLeftRoute(
        BlocProvider<MoviesBloc>(
          create: (context) => MoviesBloc(context.read<MovieRepositoryBase>()),
          child: MoviesPage(movie: arguments.movie),
        ),
      );
    } else {
      throw Exception(
        'Invalid argument provided for \'/movie\' route, it requires a $MovieArgument but got a ${arguments.runtimeType}',
      );
    }

    return movieRoute;
  }
}
