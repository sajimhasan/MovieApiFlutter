import 'package:movie_api_flutter/ReviewModel.dart';

class Moviemodel {
  final Object id;
  final String imdbId;
  final String title;
  final String releaseDate;
  final String trailerLink;
  final String poster;
  final List<String> genres;
  final List<String> backdrops;
  final List<Review> reviewIds;
  const Moviemodel({
    required this.backdrops,
    required this.genres,
    required this.id,
    required this.imdbId,
    required this.poster,
    required this.releaseDate,
    required this.reviewIds,
    required this.title,
    required this.trailerLink,
  });

  factory Moviemodel.fromJson(Map<String, dynamic> json) {
  return Moviemodel(
    id: json['id'],
    title: json['title'],
    poster: json['poster'],
    releaseDate: json['releaseDate'],
    trailerLink: json['trailerLink'],
    genres: List<String>.from(json['genres'] ?? []),
    backdrops: List<String>.from(json['backdrops'] ?? []),
    imdbId: json['imdbId'],
    reviewIds: List<Review>.from(json['reviewIds'] ?? []),
  );
}
}
