import 'package:todo_movies/src/shared/modules/http_client/utils.dart';

class RequestData {
  final Map<String, dynamic>? query;
  final JSON? body;

  const RequestData({this.query, this.body});
}
