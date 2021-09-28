// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as num,
      title: json['title'] as String,
      popularity: json['popularity'] as num?,
      voteCount: json['vote_count'] as num?,
      voteAverage: json['vote_average'] as num?,
      posterPath: json['poster_path'] as String?,
      overview: json['overview'] as String?,
      releaseDate: json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'popularity': instance.popularity,
      'overview': instance.overview,
      'vote_count': instance.voteCount,
      'vote_average': instance.voteAverage,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate?.toIso8601String(),
    };
