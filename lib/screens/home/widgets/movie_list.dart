import '../../../bloc/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_spinner.dart';
import 'movie_tile.dart';

class MovieList extends StatefulWidget {
  MovieList({Key key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _movieBloc = BlocProvider.of<MovieBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MovieFailure) {
          return Center(
            child: Text('An error ocurred while fetching movies.'),
          );
        }
        if (state is MovieSuccess) {
          if (state.movies.isEmpty) {
            return Center(
              child: Text('No movies found.'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.movies.length
                  ? BottomSpinner()
                  : MovieTile(movie: state.movies[index]);
            },
            itemCount: state.currentPage == 100
                ? state.movies.length
                : state.movies.length + 1,
            controller: _scrollController,
          );
        } else {
          return Center(
            child: Text('Unknown bloc state'),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _movieBloc.add(MoviesFetch());
    }
  }
}
