import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/usecases/get_movie_list/get_movie_list.dart';
import 'package:cinema_app/domain/usecases/get_movie_list/get_movie_list_param.dart';
import 'package:cinema_app/presentation/providers/usecase/movie/movie_list/get_movie_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'upcoming_provider.g.dart';

@Riverpod(keepAlive: true)
class Upcoming extends _$Upcoming {
  @override
  FutureOr<List<Movie>> build() => [];

  Future<void> getMovies({page = 1}) async {
    state = const AsyncLoading();

    GetMovieList getMovieList = ref.read(getMovieListProvider);

    final result = await getMovieList.call(
        GetMovieListParam(category: MovieCategoryParam.upcoming, page: page));

    switch (result) {
      case Success(value: final movies):
        state = AsyncData(movies);
      case Failed(errorMessage:_):
        state = const AsyncData([]);
    }
  }
}
