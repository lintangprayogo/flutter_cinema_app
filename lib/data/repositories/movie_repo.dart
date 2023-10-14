import 'package:cinema_app/domain/entities/actor.dart';
import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/domain/entities/movie_detail.dart';
import 'package:cinema_app/domain/entities/result.dart';

abstract interface class MovieRepo {
  Future<Result<List<Movie>>> getNowPlaying({int page = 1});
  Future<Result<List<Movie>>> getUpcoming({int page = 1});
  Future<Result<MovieDetail>> getDetail({required String id});
    Future<Result<List<Actor>>> getActors({required String id});
}
