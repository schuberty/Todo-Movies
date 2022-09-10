import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_movies/src/app_widget.dart';
import 'package:todo_movies/src/shared/app/app_constants.dart';
import 'package:todo_movies/src/shared/modules/http_client/utils.dart';

void main() {
  _checkConstants();
  _initialConfigutarion();

  runApp(const TodoMoviesApp());
}

void _checkConstants() {
  if (AMDBAPI.tmdbApiKey.isEmpty) {
    throw Exception(
      'API Key for The Movie Database API must not be empty! Check the README file for more details.',
    );
  }
}

void _initialConfigutarion() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: AppConstants.backgroundColor),
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: AppConstants.backgroundColor,
  ));
}
