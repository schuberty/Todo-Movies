part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<MovieEntity> movies;
  final Map<int, String> genres;

  const MoviesLoaded(this.movies, {this.genres = const {}});

  @override
  List<Object> get props => [movies, genres];
}

class MoviesError extends MoviesState {}
