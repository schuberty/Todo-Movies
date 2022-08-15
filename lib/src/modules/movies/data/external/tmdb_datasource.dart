import 'package:todo_movies/src/modules/movies/domain/datasources/movie_datasource_base.dart';
import 'package:todo_movies/src/shared/modules/http_client/domain/services/client_service_base.dart';
import 'package:todo_movies/src/shared/modules/http_client/domain/value_objects/request_data.dart';
import 'package:todo_movies/src/shared/modules/http_client/utils.dart';

class TMDBDatasource implements MovieDatasourceBase {
  final ClientServiceBase client;

  TMDBDatasource(this.client);

  @override
  Future<JSON> getMovieDetail(int movieId) async {
    final data = await client.get('/movie/$movieId');
    return data.right;
  }

  @override
  Future<List<JSON>> getMovieGenres() async {
    final response = await client.get('/genre/movie/list');
    final data = response.right['genres'];
    return data;
  }

  @override
  Future<List<JSON>> getSimilarMovies(int movieId, {int page = 1}) async {
    final response = await client.get(
      '/movie/$movieId/similar',
      data: RequestData(query: {'page': page}),
    );
    final data = response.right['results'];
    return data;
  }

  @override
  Future<List<JSON>> getMoviesNowPlaying({int page = 1}) async {
    final response = await client.get(
      '/movie/now_playing',
      data: RequestData(query: {'page': page}),
    );
    final data = response.right['results'];
    return data;
  }
}
