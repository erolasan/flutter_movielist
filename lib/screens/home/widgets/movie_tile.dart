import 'package:movielist/models/movie.dart';
import 'package:movielist/screens/movie_details/movie_details.dart';

import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetails(
                    movie: movie,
                  ))),
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey[400]!))),
        padding: const EdgeInsets.all(20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Flexible(
            child: Text(movie.title, overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(Icons.chevron_right)
        ]),
      ),
    );
  }
}
