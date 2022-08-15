import 'package:provider/provider.dart';
import 'package:todo_movies/src/shared/modules/http_client/data/services/client_service.dart';
import 'package:todo_movies/src/shared/modules/http_client/domain/services/client_service_base.dart';

final sharedModules = [
  Provider<ClientServiceBase>(
    create: (context) => ClientService(),
  ),
];
