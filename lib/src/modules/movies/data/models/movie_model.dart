import 'package:todo_movies/src/modules/movies/data/value_objects/title.dart';
import 'package:todo_movies/src/modules/movies/domain/entities/movie_entity.dart';
import 'package:todo_movies/src/shared/modules/http_client/utils.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.id,
    required super.title,
    required super.releaseDate,
    required super.genreIds,
    required super.overview,
    required super.originalLanguage,
    required super.urlBackdropImage,
    required super.urlPosterImage,
    required super.popularity,
    required super.voteAverage,
    required super.voteCount,
    required super.hasVideo,
    required super.isAdult,
  });

  MovieModel.fromMap(JSON map)
      : super(
          id: map['id'],
          title: MovieTitle.fromMap(map),
          releaseDate: (map['release_date'] as String).isNotEmpty
              ? DateTime.parse(map['release_date'])
              : null,
          genreIds: (map['genre_ids'] as List).map((element) {
            if (element is int) {
              return element;
            }
          }).toList(),
          overview: map['overview'],
          originalLanguage: map['original_language'],
          urlBackdropImage: '${AMDBAPI.assetsUrl}/${map['backdrop_path']}',
          urlPosterImage: '${AMDBAPI.assetsUrl}/${map['poster_path']}',
          popularity: map['popularity'],
          voteAverage: map['vote_average'] + 0.0,
          voteCount: map['vote_count'],
          hasVideo: map['video'],
          isAdult: map['adult'],
        );

  @override
  String toString() {
    return 'Movie $id (${title.original}, $voteCount votes, $popularity popularity, ${releaseDate?.year ?? ''} and ${genreIds.length} genres)';
  }
}
