import 'package:todo_movies/src/modules/movies/value_objects/title.dart';

class MovieEntity {
  late final int id;
  late final MovieTitle title;
  late final DateTime? releaseDate;
  late final List<int?> genreIds;
  late final String overview;
  late final String originalLanguage;
  late final String urlBackdropImage;
  late final String urlPosterImage;
  late final double popularity;
  late final double voteAverage;
  late final int voteCount;
  late final bool hasVideo;
  late final bool isAdult;

  MovieEntity({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.genreIds,
    required this.overview,
    required this.originalLanguage,
    required this.urlBackdropImage,
    required this.urlPosterImage,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    required this.hasVideo,
    required this.isAdult,
  });
}
