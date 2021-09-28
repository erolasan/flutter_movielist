import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movielist/bloc/movie_bloc.dart';
import 'package:movielist/models/movie.dart';
import 'package:movielist/repos/movie_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieRepository extends Mock implements IMovieRepository {}

void main() {
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
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

    blocTest('emits MovieSuccess when successful',
        build: () {
          when(() => mockMovieRepository.fetchMovies(1)).thenAnswer((_) async => movies);
          return MovieBloc(movieRepository: mockMovieRepository);
        },
        act: (dynamic bloc) => bloc.add(MoviesFetch()),
        wait: const Duration(milliseconds: 500),
        expect: () => [MovieSuccess(movies: movies, currentPage: 1)]);

    blocTest('emits MovieFailure when unsuccessful',
        build: () {
          when(() => mockMovieRepository.fetchMovies(1)).thenThrow(const HttpException("Error while fetching movies"));
          return MovieBloc(movieRepository: mockMovieRepository);
        },
        act: (dynamic bloc) => bloc.add(MoviesFetch()),
        wait: const Duration(milliseconds: 500),
        expect: () => [MovieFailure()]);
  });
}
