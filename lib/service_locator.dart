import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';

import 'repos/movie_client.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<MovieApiClient>(MovieApiClient(Dio()));
  locator.registerSingleton(Logger());
}
