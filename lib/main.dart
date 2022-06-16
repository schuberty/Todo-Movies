import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_movies/src/shared/app_constants.dart';

import 'src/app_widget.dart';

void main() {
  _initialConfigutarion();
  runApp(const TodoMoviesApp());
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
