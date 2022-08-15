import 'package:todo_movies/src/shared/modules/http_client/utils.dart';

abstract class MovieDatasourceBase {
  Future<JSON> getMovieDetail(int movieId);

  Future<List<JSON>> getMoviesNowPlaying({int page = 1});

  Future<List<JSON>> getSimilarMovies(int movieId, {int page = 1});

  Future<List<JSON>> getMovieGenres();
}
