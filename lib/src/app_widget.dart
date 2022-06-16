import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_movies/src/modules/movies/movie_module.dart';
import 'package:todo_movies/src/shared/app_router.dart';
import 'package:todo_movies/src/shared/app_theme.dart';
import 'package:todo_movies/src/shared/modules/shared_modules.dart';

class TodoMoviesApp extends StatelessWidget {
  const TodoMoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...sharedModules,
        ...movieModules,
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        onGenerateRoute: AppRouter.onGenerateRoutes,
      ),
    );
  }
}
