import 'package:todo_movies/src/modules/movies/infra/datasources/movie_datasource_base.dart';
import 'package:todo_movies/src/shared/app_constants.dart';
import 'package:todo_movies/src/shared/modules/api_service/domain/services/api_service_base.dart';

class TMDBDatasource implements MovieDatasourceBase {
  final ApiServiceBase client;

  TMDBDatasource(this.client);

  @override
  Future<ResponseMap> getMovieDetail(int movieId) async {
    final data = await client.get('/movie/$movieId');
    return data;
  }

  @override
  Future<List<ResponseMap>> getMovieGenres() async {
    final response = await client.get('/genre/movie/list');
    final data = response['genres'];
    return data;
  }

  @override
  Future<List<ResponseMap>> getSimilarMovies(int movieId, {int page = 1}) async {
    final response = await client.get(
      '/movie/$movieId/similar',
      query: {'page': page},
    );
    final data = response['results'];
    return data;
  }

  @override
  Future<List<ResponseMap>> getMoviesNowPlaying({int page = 1}) async {
    final response = await client.get(
      '/movie/now_playing',
      query: {'page': page},
    );
    final data = response['results'];
    return data;
  }
}
