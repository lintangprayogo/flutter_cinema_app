import 'package:cinema_app/domain/usecases/get_movie_list/get_movie_list.dart';
import 'package:cinema_app/presentation/providers/repo/movie/movie_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_movie_list_provider.g.dart';

@riverpod
GetMovieList getMovieList(GetMovieListRef ref) =>
    GetMovieList(movieRepo: ref.watch(movieRepoProvider));
