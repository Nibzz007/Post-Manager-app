import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;
  final double voteAverage;

  const MovieEntity({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.voteAverage = 0,
  });

  @override
  List<Object?> get props => [id, title, overview, posterPath, releaseDate, voteAverage];
}
