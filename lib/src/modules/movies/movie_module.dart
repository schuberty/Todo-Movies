import 'package:provider/provider.dart';
import 'package:todo_movies/src/modules/movies/domain/repositories/movie_repository_base.dart';
import 'package:todo_movies/src/modules/movies/external/tmdb_datasource.dart';
import 'package:todo_movies/src/modules/movies/infra/datasources/movie_datasource_base.dart';
import 'package:todo_movies/src/modules/movies/infra/repositories/movie_repository.dart';
import 'package:todo_movies/src/shared/modules/api_service/domain/services/api_service_base.dart';

final movieModules = [
  Provider<MovieDatasourceBase>(
    create: (context) => TMDBDatasource(context.read<ApiServiceBase>()),
  ),
  Provider<MovieRepositoryBase>(
    create: (context) => MovieRepository(context.read<MovieDatasourceBase>()),
  ),
  // Each MovieBloc is provided in the routing to avoid states being overwrited.
];
