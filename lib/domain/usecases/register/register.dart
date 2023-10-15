import 'package:cinema_app/data/repositories/auth_repo.dart';
import 'package:cinema_app/data/repositories/user_repo.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/entities/user.dart';
import 'package:cinema_app/domain/usecases/register/register_param.dart';
import 'package:cinema_app/domain/usecases/usecase.dart';

class Register implements UseCase<Result<User>, RegisterParam> {
  final UserRepo _userRepo;
  final AuthRepo _authRepo;

  Register({required UserRepo userRepo, required AuthRepo authRepo})
      : _userRepo = userRepo,
        _authRepo = authRepo;

  @override
  Future<Result<User>> call(RegisterParam params) async {
    final idResult = await _authRepo.register(
        email: params.email, password: params.password);

    if (idResult is Success) {
      return await _userRepo.createUser(
          uid: idResult.resultValue!,
          email: params.email,
          name: params.name,
          photoUrl: params.photoUrl);
    } else {
      return Failed(idResult.errorMessage!);
    }
  }
}
