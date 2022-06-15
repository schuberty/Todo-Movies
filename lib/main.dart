import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_movies/src/app_widget.dart';

void main() {
  _initialConfigutarion();
  runApp(const TodoMoviesApp());
}

void _initialConfigutarion() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
  );
}
