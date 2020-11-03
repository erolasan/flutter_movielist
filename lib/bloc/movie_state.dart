part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieSuccess extends MovieState {
  final List<Movie> movies;
  final int currentPage;

  const MovieSuccess({this.movies, this.currentPage});

  @override
  List<Object> get props => [movies, currentPage];

  @override
  String toString() =>
      'MovieSuccess { movies: ${movies.length}, currentPage: $currentPage }';
}

class MovieFailure extends MovieState {}
