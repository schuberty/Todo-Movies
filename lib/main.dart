import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_movies/src/shared/app_constants.dart';
import 'package:todo_movies/src/shared/app_secrets.dart';

import 'src/app_widget.dart';

void main() {
  _checkConstants();
  _initialConfigutarion();
  runApp(const TodoMoviesApp());
}

void _checkConstants() {
  if (apiKeyMovieDB.isEmpty) {
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
    const SystemUiOverlayStyle(statusBarColor: cBackgroundColor),
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: cBackgroundColor,
  ));
}
