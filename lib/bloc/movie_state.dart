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
  final int totalPages;

  const MovieSuccess({required this.movies, required this.currentPage, required this.totalPages});

  @override
  List<Object> get props => [movies, currentPage, totalPages];

  @override
  String toString() => 'MovieSuccess { movies: ${movies.length}, currentPage: $currentPage, totalPages: $totalPages }';
}

class MovieFailure extends MovieState {}
