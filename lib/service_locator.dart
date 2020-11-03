import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import 'repos/movie_repo.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<IMovieRepository>(
      MovieRepository(httpClient: http.Client()));
  locator.registerSingleton(Logger());
}
