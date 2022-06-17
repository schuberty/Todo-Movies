import 'package:todo_movies/src/shared/app_constants.dart';

abstract class MovieDatasourceBase {
  Future<ResponseMap> getMovieDetail(int movieId);

  Future<List<ResponseMap>> getMoviesNowPlaying({int page = 1});

  Future<List<ResponseMap>> getSimilarMovies(int movieId, {int page = 1});

  Future<List<ResponseMap>> getMovieGenres();
}
