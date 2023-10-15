import 'package:cinema_app/data/repositories/movie_repo.dart';
import 'package:cinema_app/domain/entities/actor.dart';
import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/domain/entities/movie_detail.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:dio/dio.dart';

class MovieTmdbRepo implements MovieRepo {
  MovieTmdbRepo({Dio? dio}) : _dio = dio ?? Dio();

  final BASE_URL = "https://api.themoviedb.org/3/movie/";

  final _accessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyODg5Yjc2MTY1NzRkYzczNTVhMzI4ZWJmNWNkZTdlMyIsInN1YiI6IjVkMzU3ODIxYmVmYjA5MDAxMGI5MjJjNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jXrGdDXq5_Z1dENIntyWBx_YbWaNsPOC-8rZu9YKJuA";

  final Dio? _dio;
  late final Options _options = Options(headers: {
    'Authorization': 'bearer $_accessToken',
    'accept': 'application/json'
  });

  @override
  Future<Result<List<Actor>>> getActors({required String id}) async {
    try {
      final response = await _dio!.get("$BASE_URL$id/credits?language=en-US");
      final result = List<Map<String, dynamic>>.from(response.data['cast']);
      return Success(result.map((e) => Actor.fromJSON(e)).toList());
    } on DioException catch (e) {
      return Failed(e.message ?? "Unknown Error");
    }
  }

  @override
  Future<Result<MovieDetail>> getDetail({required String id}) async {
    try {
      final response =
          await _dio!.get("$BASE_URL$id?language=en-US", options: _options);
      if (response.statusCode == 200) {
        return Success(MovieDetail.fromJSON(response.data));
      } else {
        return Failed(response.data["status_message"] ?? "Unknown Error");
      }
    } on DioException catch (e) {
      return Failed(e.message ?? "Unknown Error");
    }
  }

  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) async {
    return await _getMovies(_MovieCategory.nowPlaying._inString);
  }

  @override
  Future<Result<List<Movie>>> getUpcoming({int page = 1}) async {
    return await _getMovies(_MovieCategory.upComing._inString);
  }

  Future<Result<List<Movie>>> _getMovies(String category,
      {int page = 1}) async {
    try {
      final response = await _dio!.get(
          "$BASE_URL$category?language=en-US&page=$page",
          options: _options);

      final results = List<Map<String, dynamic>>.from(response.data["results"]);

      return Success(results.map((e) => Movie.fromJSON(e)).toList());
    } on DioException catch (e) {
      return Failed(e.message ?? "Unknown Error");
    }
  }
}

enum _MovieCategory {
  nowPlaying("now_playing"),
  upComing("upcoming");

  final String _inString;

  const _MovieCategory(String inString) : _inString = inString;

  @override
  String toString() => _inString;
}
