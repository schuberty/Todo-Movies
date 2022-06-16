import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:todo_movies/src/shared/modules/api_service/domain/services/api_service_base.dart';
import 'package:todo_movies/src/shared/modules/api_service/infra/services/api_service.dart';

void main() {
  group('ApiService', () {
    late final Dio dio;
    late final DioAdapter dioAdapter;
    late final ApiServiceBase service;

    const String endpoint = '/is_number_pair';

    setUp(() {
      dio = Dio(BaseOptions());
      dioAdapter = DioAdapter(dio: dio);
      service = ApiService(apiKey: 'unussedKey', dio: dio);
      dio.httpClientAdapter = dioAdapter;

      dioAdapter.onGet(
        endpoint,
        queryParameters: {'number': 11},
        (server) => server.reply(200, {
          'number': 11,
          'result': false,
        }),
      );
    });

    test('get', () async {
      final data = await service.get(
        endpoint,
        query: {'number': 11},
      );
      expect(data['number'], 11);
      expect(data['result'], false);
    });
  });
}
