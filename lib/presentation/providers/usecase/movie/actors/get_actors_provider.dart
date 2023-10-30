import 'package:cinema_app/domain/usecases/get_actors/get_actors.dart';
import 'package:cinema_app/presentation/providers/repo/movie/movie_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_actors_provider.g.dart';

@riverpod
GetActors getActors(GetActorsRef ref) =>
    GetActors(movieRepo: ref.watch(movieRepoProvider));

