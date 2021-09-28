import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movielist/bloc/event_transformers.dart';
import 'package:movielist/models/movie.dart';
import 'package:movielist/repos/movie_repo.dart';
import 'package:logger/logger.dart';
import '../service_locator.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final IMovieRepository movieRepository;

  MovieBloc({required this.movieRepository}) : super(MovieInitial()) {
    on<MoviesFetch>(_onMoviesFetch, transformer: debounce(const Duration(milliseconds: 500)));
  }

  void _onMoviesFetch(MovieEvent event, Emitter<MovieState> emit) async {
    try {
      if (state is MovieInitial) {
        List<Movie> movies = await movieRepository.fetchMovies(1);
        return emit(MovieSuccess(movies: movies, currentPage: 1));
      }
      if (state is MovieSuccess && !_hasReachedLastPage(state as MovieSuccess)) {
        List<Movie> movies = await movieRepository.fetchMovies((state as MovieSuccess).currentPage + 1);
        return emit(MovieSuccess(
            movies: (state as MovieSuccess).movies + movies, currentPage: (state as MovieSuccess).currentPage + 1));
      }
    } catch (_) {
      emit(MovieFailure());
      locator<Logger>().e('Error ocurred while fetching movies');
    }
  }

  bool _hasReachedLastPage(MovieSuccess state) {
    return state.currentPage >= 100;
  }
}
