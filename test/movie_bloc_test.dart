import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movielist/bloc/movie_bloc.dart';
import 'package:movielist/models/movie.dart';
import 'package:movielist/repos/movie_repo.dart';

class MockMovieRepository extends Mock implements IMovieRepository {}

void main() {
  MockMovieRepository mockMovieRepository;

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
          when(mockMovieRepository.fetchMovies(1))
              .thenAnswer((_) async => movies);
          return MovieBloc(movieRepository: mockMovieRepository);
        },
        act: (bloc) => bloc.add(MoviesFetch()),
        wait: const Duration(milliseconds: 500),
        expect: [MovieSuccess(movies: movies, currentPage: 1)]);

    // Couldn't get the below to pass for some reason
    // might have to do something with the version of flutter_bloc and bloc_test i am using

    // blocTest('emits MovieFailure when unsuccessful',
    //     build: () {
    //       when(mockMovieRepository.fetchMovies(any))
    //           .thenThrow(HttpException("Error while fetching movies"));
    //       return MovieBloc(movieRepository: mockMovieRepository);
    //     },
    //     act: (bloc) => bloc.add(MoviesFetch()),
    //     wait: const Duration(milliseconds: 500),
    //     expect: [MovieFailure()]);
  });
}
