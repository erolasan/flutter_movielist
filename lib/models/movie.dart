import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie extends Equatable {
  final num id;
  final String title;
  final num? popularity;
  final String? overview;
  @JsonKey(name: 'vote_count')
  final num? voteCount;
  @JsonKey(name: 'vote_average')
  final num? voteAverage;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  final DateTime? releaseDate;

  const Movie(
      {required this.id,
      required this.title,
      this.popularity,
      this.voteCount,
      this.voteAverage,
      this.posterPath,
      this.overview,
      this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  List<Object?> get props => [id, popularity, voteCount, voteAverage, posterPath, title, overview, releaseDate];

  @override
  String toString() =>
      'Movie {id: $id, title: $title, popularity: $popularity, overview: $overview, releaseDate: $releaseDate}';
}
