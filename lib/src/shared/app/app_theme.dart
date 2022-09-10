import 'package:flutter/material.dart';
import 'package:todo_movies/src/shared/app/app_constants.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get themeData => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppConstants.backgroundColor,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.transparent,
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          displayMedium: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          labelLarge: TextStyle(
            color: Colors.grey.shade200,
            fontSize: 16,
          ),
          labelMedium: TextStyle(
            color: Colors.grey.shade300,
            fontSize: 14,
          ),
        ),
      );
}
