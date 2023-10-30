import 'dart:async';

import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/usecases/get_movie_list/get_movie_list.dart';
import 'package:cinema_app/domain/usecases/get_movie_list/get_movie_list_param.dart';
import 'package:cinema_app/presentation/providers/usecase/movie/movie_list/get_movie_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'now_playing_provider.g.dart';

@Riverpod(keepAlive: true)
class NowPlaying extends _$NowPlaying {
  @override
  FutureOr<List<Movie>> build() => [];

  Future<void> getMovies({int page = 1}) async {
    state = const AsyncLoading();

    GetMovieList getMovieList = ref.read(getMovieListProvider);

    final result = await getMovieList.call(
        GetMovieListParam(category: MovieCategoryParam.nowPlaying, page: page));

    if (result is Success) {
      state = AsyncData(result.resultValue!);
    } else {
      state = const AsyncData([]);
    }
  }
}
