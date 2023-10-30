import 'package:cinema_app/data/repositories/movie_repo.dart';
import 'package:cinema_app/domain/entities/actor.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/usecases/get_actors/get_actors_param.dart';
import 'package:cinema_app/domain/usecases/usecase.dart';

class GetActors implements UseCase<Result<List<Actor>>, GetActorsParam> {
  final MovieRepo _movieRepo;

  GetActors({required MovieRepo movieRepo}) : _movieRepo = movieRepo;
  @override
  Future<Result<List<Actor>>> call(GetActorsParam params) async {
    return await _movieRepo.getActors(id: params.movieId);
  }
}
