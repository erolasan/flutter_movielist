import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movielist/models/movie.dart';
import 'package:movielist/repos/movie_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';

import '../service_locator.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final IMovieRepository movieRepository;

  MovieBloc({@required this.movieRepository}) : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is MoviesFetch) {
      try {
        if (state is MovieInitial) {
          List<Movie> movies = await movieRepository.fetchMovies(1);
          yield MovieSuccess(movies: movies, currentPage: 1);
        }
        if (state is MovieSuccess && !_hasReachedLastPage(state)) {
          List<Movie> movies = await movieRepository
              .fetchMovies((state as MovieSuccess).currentPage + 1);
          yield MovieSuccess(
              movies: (state as MovieSuccess).movies + movies,
              currentPage: (state as MovieSuccess).currentPage + 1);
        }
      } catch (_) {
        locator<Logger>().e('Error ocurred while fetching movies');
        yield MovieFailure();
      }
    }
  }

  @override
  Stream<Transition<MovieEvent, MovieState>> transformEvents(
      Stream<MovieEvent> events, transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  bool _hasReachedLastPage(MovieSuccess state) {
    return state.currentPage >= 100;
  }
}
