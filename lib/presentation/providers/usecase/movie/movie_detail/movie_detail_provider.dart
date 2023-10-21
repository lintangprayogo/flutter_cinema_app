import 'package:cinema_app/domain/entities/movie_detail.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/usecases/get_movie_detail/get_movie_detail.dart';
import 'package:cinema_app/domain/usecases/get_movie_detail/get_movie_detail_param.dart';
import 'package:cinema_app/presentation/providers/repo/movie/movie_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'movie_detail_provider.g.dart';

@riverpod
Future<MovieDetail?> movieDetail(MovieDetailRef ref,
    {required GetMovieDetailParam params}) async {
  GetMovieDetail getMovieDetail =
      GetMovieDetail(movieRepo: ref.read(movieRepoProvider));

  final result = await getMovieDetail.call(params);
  switch (result) {
    case Success(value: final movie):
      return movie;
    case Failed(errorMessage: _):
      return null;
  }
}
