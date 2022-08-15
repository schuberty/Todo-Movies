import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:todo_movies/src/modules/movies/domain/entities/movie_entity.dart';

class MovieBannerTile extends StatelessWidget {
  final MovieEntity movie;
  final List<String> genreList;
  final double width;
  final Color color;

  const MovieBannerTile({
    required this.movie,
    required this.genreList,
    required this.width,
    this.color = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String genresText = '';
    for (String genre in genreList) {
      genresText += '$genre, ';
    }
    genresText = genresText.replaceRange(genresText.length - 2, null, '');

    return Row(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: movie.urlPosterImage,
          width: width * 0.2,
          height: (width * 0.2) * 1.5,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movie.title.translated,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    movie.releaseDate?.year.toString() ?? '',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: color),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      genresText,
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
