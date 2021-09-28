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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          title: const Text('Movie List'),
        ),
        body: BlocProvider(
          create: (context) =>
              MovieBloc(movieRepository: locator<IMovieRepository>())
                ..add(MoviesFetch()),
          child: const HomePage(),
        ),
      ),
    );
  }
}
