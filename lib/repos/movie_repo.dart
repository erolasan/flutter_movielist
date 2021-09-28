import 'dart:convert';
import 'dart:io';

import 'package:movielist/models/movie.dart';
import 'package:http/http.dart' as http;

abstract class IMovieRepository {
  Future<List<Movie>> fetchMovies(int pageToFech);
}

class MovieRepository implements IMovieRepository {
  final http.Client httpClient;

  MovieRepository({required this.httpClient});

  @override
  Future<List<Movie>> fetchMovies(int pageToFetch) async {
    const apiKey = '4ff9d08260ed338797caa272d7df35dd';
    String props = 'language=en-US&sort_by=popularity.desc&page=$pageToFetch';
    final response =
        await httpClient.get(Uri.parse('https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&l$props'));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      return (responseBody['results'] as List).map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw const HttpException("Error while fetching movies");
    }
  }
}
