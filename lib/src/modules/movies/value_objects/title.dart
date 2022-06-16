import 'package:todo_movies/src/shared/app_constants.dart';

class MovieTitle {
  late final String original;
  late final String translated;

  MovieTitle({
    required this.original,
    required this.translated,
  });

  MovieTitle.fromMap(ResponseMap map) {
    original = map['original_title'];
    translated = map['title'];
  }
}
