import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_movies/src/modules/movies/bloc/movies_bloc.dart';
import 'package:todo_movies/src/modules/movies/components/movie_list_tile_widget.dart';
import 'package:todo_movies/src/shared/app_constants.dart';
import 'package:todo_movies/src/shared/arguments/movie_argument.dart';
import 'package:todo_movies/src/shared/components/glassmorphed_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<MoviesBloc>().add(const FetchMoviesNowPlaying());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Add movie list filter (by top rated, upcoming, popular, latest or now playing)
      appBar: const GlassmorphedAppBar(offset: 16, opacity: 0.4),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (_, index) {
                final movie = state.movies[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: MovieListTile(
                    movie,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/movie',
                      arguments: MovieArgument(movie: movie),
                    ),
                  ),
                );
              },
            );
          } else if (state is MoviesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: cPrimaryColor,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      // TODO: Implement favorited movie list
      // bottomNavigationBar: Glassmorphed(
      //   offset: 5,
      //   child: Container(
      //     height: 80,
      //   ),
      // ),
      extendBodyBehindAppBar: true,
      extendBody: true,
    );
  }
}
