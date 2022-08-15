import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:todo_movies/src/shared/modules/http_client/domain/services/client_service_base.dart';
import 'package:todo_movies/src/shared/modules/http_client/domain/value_objects/error_data.dart';
import 'package:todo_movies/src/shared/modules/http_client/domain/value_objects/request_data.dart';
import 'package:todo_movies/src/shared/modules/http_client/utils.dart';

class ClientService implements ClientServiceBase {
  late final Dio _client;

  ClientService({Dio? dio}) {
    final baseOptions = BaseOptions(
      baseUrl: AMDBAPI.baseUrl,
      contentType: ContentType.json.value,
      connectTimeout: 6000,
    );

    _client = dio ?? Dio(baseOptions);
    _client.interceptors.add(ClientV3AuthInterceptor(AMDBAPI.tmdbApiKey));
  }

  @override
  Future<EitherResponse> get(
    String endpoint, {
    RequestData data = const RequestData(),
    ContentType contentType = ContentType.json,
  }) async {
    late final Response response;

    try {
      response = await _client.get(
        endpoint,
        queryParameters: data.query,
        options: Options(contentType: contentType.value),
      );
    } on DioError catch (error) {
      return Left(onError(error));
    }

    return Right(response.data);
  }

  @override
  ErrorData onError(DioError error) {
    late final ErrorData errorData;

    if (error.response != null) {
      final response = error.response!;
      errorData = ErrorData(
        statusCode: response.statusCode,
        detail: response.statusMessage,
      );
    } else {
      errorData = ErrorData();
    }

    return errorData;
  }
}

class ClientV3AuthInterceptor extends Interceptor {
  final String _apiKey;

  ClientV3AuthInterceptor(String apiKey) : _apiKey = apiKey;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters["api_key"] = _apiKey;

    super.onRequest(options, handler);
  }
}
