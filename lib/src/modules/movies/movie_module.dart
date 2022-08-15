import 'package:provider/provider.dart';
import 'package:todo_movies/src/modules/movies/data/external/tmdb_datasource.dart';
import 'package:todo_movies/src/modules/movies/data/repositories/movie_repository.dart';
import 'package:todo_movies/src/modules/movies/domain/datasources/movie_datasource_base.dart';
import 'package:todo_movies/src/modules/movies/domain/repositories/movie_repository_base.dart';
import 'package:todo_movies/src/shared/modules/http_client/domain/services/client_service_base.dart';

final movieModules = [
  Provider<MovieDatasourceBase>(
    create: (context) => TMDBDatasource(context.read<ClientServiceBase>()),
  ),
  Provider<MovieRepositoryBase>(
    create: (context) => MovieRepository(context.read<MovieDatasourceBase>()),
  ),
  // Each MovieBloc is provided in the routing to avoid states being overwrited.
];
