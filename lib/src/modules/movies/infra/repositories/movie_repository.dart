import 'package:todo_movies/src/modules/movies/domain/entities/movie_entity.dart';
import 'package:todo_movies/src/modules/movies/domain/repositories/movie_repository_base.dart';
import 'package:todo_movies/src/modules/movies/infra/datasources/movie_datasource_base.dart';
import 'package:todo_movies/src/modules/movies/models/movie_model.dart';

class MovieRepository implements MovieRepositoryBase {
  final MovieDatasourceBase datasource;

  MovieRepository(this.datasource);

  @override
  Future<MovieEntity> getMovieDetail(int movieId) async {
    final data = await datasource.getMovieDetail(movieId);
    return MovieModel.fromMap(data);
  }

  @override
  Future<Map<int, String>> getMovieGenres() async {
    final data = await datasource.getMovieGenres();

    final genres = <int, String>{};
    for (var genre in data) {
      genres[genre['id']] = genre['name'];
    }

    return genres;
  }

  @override
  Future<List<MovieEntity>> getSimilarMovies(int movieId, {int page = 1}) async {
    final data = await datasource.getSimilarMovies(movieId, page: page);
    return data.map(MovieModel.fromMap).toList();
  }

  @override
  Future<List<MovieEntity>> getMoviesNowPlaying({int page = 1}) async {
    final data = await datasource.getMoviesNowPlaying(page: page);
    return data.map(MovieModel.fromMap).toList();
  }
}
