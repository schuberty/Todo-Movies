import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:todo_movies/src/modules/movies/domain/entities/movie_entity.dart';
import 'package:todo_movies/src/shared/app_constants.dart';

class MovieListTile extends StatelessWidget {
  final MovieEntity movie;
  final VoidCallback? onTap;
  final double height;

  const MovieListTile(
    this.movie, {
    this.onTap,
    this.height = 160,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            CachedNetworkImage(
              width: double.infinity,
              imageUrl: movie.urlBackdropImage,
              placeholder: (context, url) {
                return Container(
                  color: const Color(0xFF0D0F12),
                );
              },
              fadeInDuration: const Duration(milliseconds: 400),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
            Container(
              height: height * 0.8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.4),
                    Colors.transparent,
                  ],
                  stops: const [0.3, 0.75, 1.0],
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title.translated,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: cPrimaryColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${movie.voteCount} Curtidas',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
