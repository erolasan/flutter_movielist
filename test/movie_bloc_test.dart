import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movielist/bloc/movie_bloc.dart';
import 'package:movielist/models/movie.dart';
import 'package:movielist/models/movies_response.dart';
import 'package:movielist/repos/movie_client.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieClient extends Mock implements MovieApiClient {}

void main() {
  late MockMovieClient mockMovieClient;

  setUp(() {
    mockMovieClient = MockMovieClient();
  });

  group('GetMovies', () {
    final List<Movie> movies = [
      Movie(
          popularity: 10,
          id: 1,
          overview: "Movie overview",
          posterPath: "/ad2d1d12.jpg",
          releaseDate: DateTime.now(),
          title: 'Movie',
          voteAverage: 5.6,
          voteCount: 120)
    ];
    const currentPage = 1;
    const totalPages = 500;

    final MoviesResponse moviesResponse = MoviesResponse(page: currentPage, results: movies, totalPages: totalPages);

    blocTest('emits MovieSuccess when successful',
        build: () {
          when(() => mockMovieClient.fetchMovies(pageToFetch: 1)).thenAnswer((_) async => moviesResponse);
          return MovieBloc(movieClient: mockMovieClient);
        },
        act: (dynamic bloc) => bloc.add(MoviesFetch()),
        wait: const Duration(milliseconds: 500),
        expect: () => [MovieSuccess(movies: movies, currentPage: currentPage, totalPages: totalPages)]);

    blocTest('emits MovieFailure when unsuccessful',
        build: () {
          when(() => mockMovieClient.fetchMovies(pageToFetch: 1))
              .thenThrow(const HttpException("Error while fetching movies"));
          return MovieBloc(movieClient: mockMovieClient);
        },
        act: (dynamic bloc) => bloc.add(MoviesFetch()),
        wait: const Duration(milliseconds: 500),
        expect: () => [MovieFailure()]);
  });
}
