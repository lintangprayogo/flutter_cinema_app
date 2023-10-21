import 'package:cinema_app/domain/entities/actor.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/usecases/get_actors/get_actors_param.dart';
import 'package:cinema_app/presentation/providers/repo/movie/movie_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_actors_provider.g.dart';

@riverpod
Future<List<Actor>> getActors(GetActorsRef ref,
    {required GetActorsParam param}) async {
  final result =
      await ref.read(movieRepoProvider).getActors(id: param.movie.id);

  switch (result) {
    case Success(value: final actors):
      return actors;
    case Failed(errorMessage: _):
      return [];
  }
}
