
import 'package:cinema_app/data/repositories/movie_repo.dart';
import 'package:cinema_app/data/tmbd/movie_tmdb_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'movie_repo_provider.g.dart';

@Riverpod()
MovieRepo movieRepo(MovieRepoRef ref) =>MovieTmdbRepo();