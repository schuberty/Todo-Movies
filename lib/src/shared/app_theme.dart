import 'package:flutter/material.dart';
import 'package:todo_movies/src/shared/app_constants.dart';

final appTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: cBackgroundColor,
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
