// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MovieApiClient implements MovieApiClient {
  _MovieApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.themoviedb.org/3/discover/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<MoviesResponse> fetchMovies(
      {apiKey = movieApiKey,
      language = 'en-US',
      sortBy = 'popularity.desc',
      required pageToFetch}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': apiKey,
      r'language': language,
      r'sort_by': sortBy,
      r'page': pageToFetch
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MoviesResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/movie',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MoviesResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
