import 'package:cinema_app/data/repositories/movie_repo.dart';
import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/usecases/get_movie_list/get_movie_list_param.dart';
import 'package:cinema_app/domain/usecases/usecase.dart';

class GetMovieList implements UseCase<Result<List<Movie>>, GetMovieListParam> {
  final MovieRepo _movieRepo;

  GetMovieList({required MovieRepo movieRepo}) : _movieRepo = movieRepo;

  @override
  Future<Result<List<Movie>>> call(GetMovieListParam params) async {
    if (params.category == MovieCategoryParam.nowPlaying) {
      return await _movieRepo.getNowPlaying(page: params.page);
    } else {
      return await _movieRepo.getUpcoming(page: params.page);
    }
  }
}
