import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:movielist/models/movie.dart';
import 'package:http/http.dart' as http;

abstract class IMovieRepository {
  Future<List<Movie>> fetchMovies(int pageToFech);
}

class MovieRepository implements IMovieRepository {
  final http.Client httpClient;

  MovieRepository({@required this.httpClient});

  @override
  Future<List<Movie>> fetchMovies(int pageToFetch) async {
    const api_key = '4ff9d08260ed338797caa272d7df35dd';
    final response = await httpClient.get(
        'https://api.themoviedb.org/3/discover/movie?api_key=$api_key' +
            '&language=en-US&sort_by=popularity.desc&page=$pageToFetch');
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      return (responseBody['results'] as List)
          .map((movieJson) => Movie.fromJson(movieJson))
          .toList();
    } else {
      throw HttpException("Error while fetching movies");
    }
  }
}
