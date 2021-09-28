import 'package:flutter/material.dart';
import 'package:movielist/models/movie.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;
  const MovieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Movie Details')),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder_image.png',
                  image: 'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Popularity: ${movie.popularity!.ceil()}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'TMDB Score: ${movie.voteAverage} (${movie.voteCount} votes)',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(movie.overview!)
              ],
            ),
          ),
        )));
  }
}
