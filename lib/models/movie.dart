import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final num id;
  final num popularity;
  final num voteCount;
  final num voteAverage;
  final String posterPath;
  final String title;
  final String overview;
  final DateTime releaseDate;

  Movie(
      {this.popularity,
      this.voteCount,
      this.id,
      this.voteAverage,
      this.posterPath,
      this.title,
      this.overview,
      this.releaseDate});

  Movie.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        popularity = data['popularity'],
        voteCount = data['vote_count'],
        voteAverage = data['vote_average'],
        posterPath = data['poster_path'],
        title = data['title'],
        overview = data['overview'],
        releaseDate = DateTime.parse(data['release_date']);

  List<Object> get props => [
        id,
        popularity,
        voteCount,
        voteAverage,
        posterPath,
        title,
        overview,
        releaseDate
      ];

  @override
  String toString() =>
      'Movie {id: $id, title: $title, popularity: $popularity, overview: $overview, releaseDate: $releaseDate}';
}
