import 'package:todo_movies/src/modules/movies/domain/entities/movie_entity.dart';

abstract class MovieRepositoryBase {
  Future<MovieEntity> getMovieDetail(int movieId);

  Future<List<MovieEntity>> getMoviesNowPlaying({int page = 1});

  Future<List<MovieEntity>> getSimilarMovies(int movieId, {int page = 1});

  Future<Map<int, String>> getMovieGenres();
}
