import 'package:cinema_app/data/repositories/movie_repo.dart';
import 'package:cinema_app/domain/entities/movie_detail.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/usecases/get_movie_detail/get_movie_detail_param.dart';
import 'package:cinema_app/domain/usecases/usecase.dart';

class GetMovieDetail
    implements UseCase<Result<MovieDetail>, GetMovieDetailParam> {
  final MovieRepo _movieRepo;

  GetMovieDetail({required MovieRepo movieRepo}) : _movieRepo = movieRepo;
  @override
  Future<Result<MovieDetail>> call(GetMovieDetailParam params) async {
    return await _movieRepo.getDetail(id: params.movie.id);
  }
}
