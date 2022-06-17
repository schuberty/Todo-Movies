import 'package:dio/dio.dart';
import 'package:todo_movies/src/shared/app_constants.dart';

import '../../domain/services/api_service_base.dart';

/// Service that internally uses the Dio HTTP Client to make HTTP requests.
class ApiService implements ApiServiceBase {
  late final Dio _dio;
  late final Map<String, dynamic> _defaultQuery;

  static const String assetsUrl = 'https://image.tmdb.org/t/p/w780';

  static const String _apiUrl = 'https://api.themoviedb.org/3';

  /// Parameter [apiKey] is required to make requests to The Movie Database API.
  /// Can be obtained at https://www.themoviedb.org/settings/api
  ApiService({required String apiKey, Dio? dio}) {
    final BaseOptions options = BaseOptions(
      baseUrl: _apiUrl,
      connectTimeout: 5000,
    );

    _dio = dio ?? Dio(options);
    _defaultQuery = {
      'api_key': apiKey,
      'language': 'pt-BR',
    };
  }

  @override
  Future<ResponseMap> get(
    String endpoint, {
    Map<String, dynamic>? query,
  }) async {
    if (query == null) {
      query = _defaultQuery;
    } else {
      query.addAll(_defaultQuery);
    }

    final response = await _dio.get(
      endpoint,
      queryParameters: query,
    );

    return response.data as ResponseMap;
  }
}
