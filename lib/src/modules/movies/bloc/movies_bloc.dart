import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_movies/src/modules/movies/domain/entities/movie_entity.dart';
import 'package:todo_movies/src/modules/movies/domain/repositories/movie_repository_base.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepositoryBase _repository;
  final Map<int, String> _genres = {};

  MoviesBloc(MovieRepositoryBase repository)
      : _repository = repository,
        super(MoviesInitial()) {
    on<MoviesEvent>(_onMoviesInitialized);
    on<FetchMoviesNowPlaying>(_onFetchMoviesNowPlaying);
    on<FetchSimilarMovies>(_onFetchRecommendedMovies);
  }

  void _onMoviesInitialized(MoviesEvent event, Emitter emit) async {
    try {
      final genres = await _repository.getMovieGenres();
      _genres.addAll(genres);
    } catch (exception) {
      emit(MoviesError());
    }
  }

  void _onFetchMoviesNowPlaying(FetchMoviesNowPlaying event, Emitter emit) async {
    emit(MoviesLoading());

    final movies = await _repository.getMoviesNowPlaying();

    if (!isClosed) {
      emit(MoviesLoaded(movies));
    } else {
      // TODO: Add diferent error behavior for each event.
      emit(MoviesError());
    }
  }

  void _onFetchRecommendedMovies(FetchSimilarMovies event, Emitter emit) async {
    emit(MoviesLoading());

    final genres = await _repository.getMovieGenres();
    final movies = await _repository.getSimilarMovies(event.movieId);

    if (!isClosed) {
      emit(MoviesLoaded(movies, genres: genres));
    } else {
      // TODO: Add diferent error behavior for each event.
      emit(MoviesError());
    }
  }
}
