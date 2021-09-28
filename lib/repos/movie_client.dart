import 'package:dio/dio.dart';
import 'package:movielist/models/movies_response.dart';
import 'package:movielist/repos/keys.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_client.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3/discover/")
abstract class MovieApiClient {
  factory MovieApiClient(Dio dio, {String baseUrl}) = _MovieApiClient;

  @GET('/movie')
  Future<MoviesResponse> fetchMovies(
      {@Query('api_key') String apiKey = movieApiKey,
      @Query('language') String language = 'en-US',
      @Query('sort_by') String sortBy = 'popularity.desc',
      @Query('page') required int pageToFetch});
}
