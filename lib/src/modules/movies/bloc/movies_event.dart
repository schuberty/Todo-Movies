part of 'movies_bloc.dart';

class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviesNowPlaying extends MoviesEvent {
  final bool fetchGenres;

  const FetchMoviesNowPlaying({this.fetchGenres = false});

  @override
  List<Object> get props => [fetchGenres];
}

class FetchSimilarMovies extends MoviesEvent {
  final int movieId;

  const FetchSimilarMovies(this.movieId);

  @override
  List<Object> get props => [movieId];
}
