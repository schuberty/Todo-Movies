import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:todo_movies/src/shared/modules/http_client/domain/value_objects/error_data.dart';
import 'package:todo_movies/src/shared/modules/http_client/domain/value_objects/request_data.dart';
import 'package:todo_movies/src/shared/modules/http_client/utils.dart';

abstract class ClientServiceBase {
  Future<Either<ErrorData, JSON>> get(String endpoint, {RequestData data});

  ErrorData onError(DioError error);
}
