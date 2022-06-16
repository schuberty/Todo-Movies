import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_movies/src/modules/movies/components/movie_list_tile_widget.dart';
import 'package:todo_movies/src/modules/movies/domain/entities/movie_entity.dart';
import 'package:todo_movies/src/modules/movies/domain/repositories/movie_repository_base.dart';
import 'package:todo_movies/src/shared/arguments/movie_argument.dart';
import 'package:todo_movies/src/shared/components/glassmorphed_app_bar.dart';
import 'package:todo_movies/src/shared/mixins/complete_state_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with CompleteStateMixin {
  late final List<MovieEntity> movies = [];
  final List<Image> cachedImages = [];

  @override
  void completeState() async {
    movies.addAll(
      await context
          .read<MovieRepositoryBase>()
          .getMoviesNowPlaying()
          .whenComplete(() => setState(() {})),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const GlassmorphedAppBar(
        offset: 16,
        opacity: 0.4,
      ),
      extendBodyBehindAppBar: true,
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: movies.length,
        itemBuilder: (_, index) {
          final movie = movies[index];
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
      ),
    );
  }
}
