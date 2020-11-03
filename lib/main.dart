import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repos/movie_repo.dart';
import 'screens/home/home.dart';
import './bloc/movie_bloc.dart';
import './bloc_observer.dart';
import 'service_locator.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ViaBill Movielist',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Movie List'),
        ),
        body: BlocProvider(
          create: (context) =>
              MovieBloc(movieRepository: locator<IMovieRepository>())
                ..add(MoviesFetch()),
          child: HomePage(),
        ),
      ),
    );
  }
}
