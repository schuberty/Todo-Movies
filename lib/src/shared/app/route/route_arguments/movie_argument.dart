import 'package:todo_movies/src/modules/movies/domain/entities/movie_entity.dart';

/// Parameters used in the '/movie' route.
class MovieArgument {
  final MovieEntity movie;

  MovieArgument({required this.movie});
}
