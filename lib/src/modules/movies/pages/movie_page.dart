import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_movies/src/modules/movies/bloc/movies_bloc.dart';
import 'package:todo_movies/src/modules/movies/components/movie_banner_tile_widget.dart';
import 'package:todo_movies/src/modules/movies/domain/entities/movie_entity.dart';
import 'package:todo_movies/src/shared/app_constants.dart';
import 'package:todo_movies/src/shared/mixins/complete_state_mixin.dart';
import 'package:todo_movies/src/shared/utils/extensions/color_extension.dart';

class MoviesPage extends StatefulWidget {
  final MovieEntity movie;

  const MoviesPage({
    required this.movie,
    super.key,
  });

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> with CompleteStateMixin {
  late final CachedNetworkImageProvider image;

  Color mainColor = Colors.white;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    context.read<MoviesBloc>().add(FetchSimilarMovies(widget.movie.id));
    image = CachedNetworkImageProvider(widget.movie.urlPosterImage);
  }

  @override
  void completeState() async {
    // TODO: Create controller to manage app local data and implement Offline first
    final preferences = await SharedPreferences.getInstance();
    isFavorite = preferences.getBool(widget.movie.id.toString()) ?? false;

    // TODO: Fix heavy computation that stutter page animation
    final palette = await PaletteGenerator.fromImageProvider(image);
    setState(() {
      mainColor = palette.lightVibrantColor?.color ?? palette.vibrantColor?.color ?? Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final flexibleHeight = size.height * 0.5;

    return Scaffold(
      backgroundColor: cBackgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverLayoutBuilder(
            builder: (context, constraints) {
              return SliverAppBar(
                elevation: 0.0,
                toolbarHeight: 80.0,
                backgroundColor: cBackgroundColor,
                expandedHeight: flexibleHeight,
                leadingWidth: 56,
                // Pop page icon button
                leading: Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    shape: const CircleBorder(),
                    enableFeedback: false,
                    color: cBackgroundColor.withOpacity(0.5),
                    child: Icon(
                      Platform.isIOS ? Icons.arrow_back_ios_new_sharp : Icons.arrow_back_sharp,
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  // Gradient overlay
                  title: Container(
                    height: flexibleHeight - size.height * 0.15,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          cBackgroundColor.withOpacity(0.8),
                          cBackgroundColor.withOpacity(1.0),
                        ],
                        stops: const [0.6, 0.8, 1.0],
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                      ),
                    ),
                  ),
                  // Main movie poster image
                  background: Image(
                    image: image,
                    fit: BoxFit.cover,
                    width: size.width,
                    alignment: Alignment.center,
                  ),
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Movie title
                      SizedBox(
                        width: size.width * 0.7,
                        child: Text(
                          widget.movie.title.translated,
                          style:
                              Theme.of(context).textTheme.displayLarge?.copyWith(color: mainColor),
                        ),
                      ),
                      // Favorite button
                      IconButton(
                        onPressed: () async {
                          // TODO: Create controller to manage app local data
                          final preferences = await SharedPreferences.getInstance();
                          final isSaved = await preferences.setBool(
                            widget.movie.id.toString(),
                            !isFavorite,
                          );

                          if (isSaved) {
                            setState(() => isFavorite = !isFavorite);
                          } else if (!isSaved && mounted) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Erro ao favoritar ${widget.movie.title.translated}',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: cPrimaryColor,
                            ));
                          }
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_outline,
                          size: 32,
                          color: mainColor,
                        ),
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.zero,
                        splashColor: Colors.transparent,
                        enableFeedback: false,
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Current selected movie details
                  Row(
                    children: [
                      const Icon(Icons.favorite, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.movie.voteCount} Likes',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(width: 24),
                      const Icon(Icons.circle_outlined, size: 20),
                      const SizedBox(width: 8),
                      // TODO: Understand https://developers.themoviedb.org/3/getting-started/popularity parameter
                      Text(
                        '${widget.movie.popularity.round()} Popularidade',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          // Similar movie list with divider between movies
          BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              if (state is MoviesLoaded) {
                final movies = state.movies;
                final genres = state.genres;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index.isEven) {
                        // Get movie and setup genre list
                        final movie = movies[index ~/ 2];
                        final genreList = <String>[];
                        for (int? genre in movie.genreIds) {
                          if (genre != null) {
                            genreList.add(genres[genre]!);
                          }
                        }
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: MovieBannerTile(
                            movie: movie,
                            genreList: genreList,
                            width: size.width,
                            color: mainColor,
                          ),
                        );
                      } else {
                        return Divider(
                          height: 18,
                          indent: size.width * 0.2 + 30,
                          color: cBackgroundColor.lighten(0.1),
                        );
                      }
                    },
                    // Ammount of movies + divider between movies
                    childCount: max(0, movies.length * 2 - 1),
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.05),
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

    // Tests with image animation

    // return Scaffold(
    //   body: NestedScrollView(
    //     headerSliverBuilder: (context, innerBoxIsScrolled) {
    //       print(innerBoxIsScrolled);
    //       return <Widget>[
    //         SliverAppBar(
    //           pinned: true,
    //           elevation: 0.0,
    //           toolbarHeight: 80.0,
    //           shadowColor: Colors.transparent,
    //           foregroundColor: Colors.transparent,
    //           surfaceTintColor: Colors.transparent,
    //           backgroundColor: Colors.transparent,
    //           expandedHeight: flexibleHeight,
    //           flexibleSpace: LayoutBuilder(
    //             builder: (context, constraints) {
    //               top = constraints.biggest.height;
    //               return FlexibleSpaceBar(
    //                 centerTitle: true,
    //                 title: AnimatedOpacity(
    //                   duration: Duration.zero,
    //                   opacity: innerBoxIsScrolled ? 0.0 : 1.0,
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                       gradient: LinearGradient(
    //                         colors: [
    //                           Colors.black.withOpacity(0.7),
    //                           Colors.black.withOpacity(0.4),
    //                           Colors.transparent,
    //                           Colors.transparent,
    //                           Colors.black.withOpacity(0.6),
    //                           Colors.black.withOpacity(0.9),
    //                         ],
    //                         stops: const [0.0, 0.1, 0.2, 0.7, 0.9, 1.0],
    //                         begin: AlignmentDirectional.topCenter,
    //                         end: AlignmentDirectional.bottomCenter,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 background: CachedNetworkImage(
    //                   // width: size.width,
    //                   imageUrl: widget.movie.urlPosterImage,
    //                   fadeInDuration: Duration.zero,
    //                   alignment: Alignment.topCenter,

    //                   fit: BoxFit.fitWidth,
    //                 ),
    //               );
    //             },
    //           ),
    //         )
    //       ];
    //     },
    //     body: ListView.builder(
    //       itemCount: 100,
    //       itemBuilder: (context, index) {
    //         return Container(
    //           width: size.width,
    //           height: 100,
    //           margin: const EdgeInsets.symmetric(vertical: 8),
    //           color: Colors.red,
    //         );
    //       },
    //     ),
    //   ),
    // );

    // return Scaffold(
    //   body: NestedScrollView(
    //     headerSliverBuilder: (context, innerBoxIsScrolled) {
    //       return <Widget>[
    //         SliverAppBar(
    //           // pinned: true,
    //           elevation: 0.0,
    //           toolbarHeight: 80.0,
    //           shadowColor: Colors.transparent,
    //           foregroundColor: Colors.transparent,
    //           surfaceTintColor: Colors.transparent,
    //           backgroundColor: Colors.transparent,
    //           expandedHeight: flexibleHeight,
    //           flexibleSpace: LayoutBuilder(
    //             builder: (context, constraints) {
    //               return FlexibleSpaceBar(
    //                 titlePadding: EdgeInsets.zero,
    //                 title: AnimatedOpacity(
    //                   duration: Duration.zero,
    //                   opacity: innerBoxIsScrolled ? 0.0 : 1.0,
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                       gradient: LinearGradient(
    //                         colors: [
    //                           Colors.black.withOpacity(0.7),
    //                           Colors.black.withOpacity(0.4),
    //                           Colors.transparent,
    //                           Colors.transparent,
    //                           Colors.black.withOpacity(0.6),
    //                           Colors.black.withOpacity(0.9),
    //                         ],
    //                         stops: const [0.0, 0.1, 0.2, 0.7, 0.9, 1.0],
    //                         begin: AlignmentDirectional.topCenter,
    //                         end: AlignmentDirectional.bottomCenter,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 background: Stack(
    //                   fit: StackFit.loose,
    //                   children: [
    //                     CachedNetworkImage(
    //                       width: size.width,
    //                       imageUrl: widget.movie.urlPosterImage,
    //                       fadeInDuration: Duration.zero,
    //                       alignment: Alignment.topCenter,
    //                       fit: BoxFit.fitWidth,
    //                     ),
    //                     // Container(
    //                     //   decoration: BoxDecoration(
    //                     //     gradient: LinearGradient(
    //                     //       colors: [
    //                     //         Colors.black.withOpacity(0.7),
    //                     //         Colors.black.withOpacity(0.4),
    //                     //         Colors.transparent,
    //                     //         Colors.transparent,
    //                     //         Colors.black.withOpacity(0.6),
    //                     //         Colors.black.withOpacity(0.9),
    //                     //       ],
    //                     //       stops: const [0.0, 0.1, 0.2, 0.7, 0.9, 1.0],
    //                     //       begin: AlignmentDirectional.topCenter,
    //                     //       end: AlignmentDirectional.bottomCenter,
    //                     //     ),
    //                     //   ),
    //                     // ),
    //                   ],
    //                 ),
    //               );
    //             },
    //           ),
    //         ),
    //       ];
    //     },
    //     body: ListView.builder(
    //       itemCount: 100,
    //       itemBuilder: (context, index) {
    //         return Container(
    //           width: size.width,
    //           height: 100,
    //           margin: const EdgeInsets.symmetric(vertical: 8),
    //           color: Colors.yellow,
    //         );
    //       },
    //     ),
    //   ),
    // );
