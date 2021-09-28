import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movielist/bloc/event_transformers.dart';
import 'package:movielist/models/movie.dart';
import 'package:movielist/models/movies_response.dart';
import 'package:movielist/repos/movie_client.dart';
import 'package:logger/logger.dart';
import '../service_locator.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieApiClient movieClient;

  MovieBloc({required this.movieClient}) : super(MovieInitial()) {
    on<MoviesFetch>(_onMoviesFetch, transformer: debounce(const Duration(milliseconds: 500)));
  }

  void _onMoviesFetch(MovieEvent event, Emitter<MovieState> emit) async {
    try {
      if (state is MovieInitial) {
        MoviesResponse response = await movieClient.fetchMovies(pageToFetch: 1);
        return emit(
            MovieSuccess(movies: response.results, currentPage: response.page, totalPages: response.totalPages));
      }
      if (state is MovieSuccess && !_hasReachedLastPage(state as MovieSuccess)) {
        MoviesResponse response = await movieClient.fetchMovies(pageToFetch: (state as MovieSuccess).currentPage + 1);
        return emit(MovieSuccess(
            movies: (state as MovieSuccess).movies + response.results,
            currentPage: response.page,
            totalPages: response.totalPages));
      }
    } catch (_) {
      emit(MovieFailure());
      locator<Logger>().e('Error ocurred while fetching movies');
    }
  }

  bool _hasReachedLastPage(MovieSuccess state) {
    return state.currentPage >= state.totalPages;
  }
}
