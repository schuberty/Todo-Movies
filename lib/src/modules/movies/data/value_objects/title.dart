import 'package:todo_movies/src/shared/modules/http_client/utils.dart';

class MovieTitle {
  late final String original;
  late final String translated;

  MovieTitle({
    required this.original,
    required this.translated,
  });

  MovieTitle.fromMap(JSON map) {
    original = map['original_title'];
    translated = map['title'];
  }
}
