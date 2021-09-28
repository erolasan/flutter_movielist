import 'package:json_annotation/json_annotation.dart';
import 'package:movielist/models/movie.dart';

part 'movies_response.g.dart';

@JsonSerializable()
class MoviesResponse {
  final int page;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final List<Movie> results;

  MoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) => _$MoviesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesResponseToJson(this);
}
