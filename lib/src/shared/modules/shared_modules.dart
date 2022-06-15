import 'package:provider/provider.dart';
import 'package:todo_movies/src/shared/app_secrets.dart';
import 'package:todo_movies/src/shared/modules/api_service/domain/services/api_service_base.dart';
import 'package:todo_movies/src/shared/modules/api_service/infra/services/api_service.dart';

final sharedModules = [
  Provider<ApiServiceBase>(
    create: (context) => ApiService(apiKey: apiKeyMovieDB),
  ),
];
