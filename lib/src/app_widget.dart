import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_movies/src/app_modules.dart';
import 'package:todo_movies/src/shared/app/app_router.dart';
import 'package:todo_movies/src/shared/app/app_theme.dart';

class TodoMoviesApp extends StatelessWidget {
  const TodoMoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appModules,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        onGenerateRoute: AppRouter.onGenerateRoutes,
      ),
    );
  }
}
