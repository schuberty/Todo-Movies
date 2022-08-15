import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:todo_movies/src/shared/modules/http_client/domain/value_objects/error_data.dart';

typedef JSON = dynamic;
typedef EitherResponse = Either<ErrorData, JSON>;

enum ContentType {
  form(Headers.formUrlEncodedContentType),
  json(Headers.jsonContentType);

  final String value;

  const ContentType(this.value);

  @override
  String toString() => value;
}

class AMDBAPI {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String assetsUrl = "https://image.tmdb.org/t/p/w780";

  /// Value [tmdbApiKey] is required to make requests to The Movie Database API.
  /// Can be obtained at https://www.themoviedb.org/settings/api
  static const String tmdbApiKey = "befa416ffe8b41980191399bdf800b1e";
  static const String tmdbApiLocale = "pt-BR";
}
