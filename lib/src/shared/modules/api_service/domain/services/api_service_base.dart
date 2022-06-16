import 'package:todo_movies/src/shared/app_constants.dart';

abstract class ApiServiceBase {
  Future<ResponseMap> get(String endpoint, {Map<String, dynamic>? query});
}
