import 'package:freezed_annotation/freezed_annotation.dart';
part 'movie.freezed.dart';

@freezed
class Movie with _$Movie {
  const factory Movie(
      {required String id,
      required String posterPath,
      required String title}) = _Movies;

  factory Movie.fromJSON(Map<String, dynamic> json) => Movie(
      id: json["id"].toString(), title: json["title"], posterPath: json["poster_path"]);
}
