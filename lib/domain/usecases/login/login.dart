import 'package:cinema_app/data/repositories/auth_repo.dart';
import 'package:cinema_app/data/repositories/user_repo.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/entities/user.dart';
import 'package:cinema_app/domain/usecases/login/login_params.dart';
import 'package:cinema_app/domain/usecases/usecase.dart';

class Login implements UseCase<Result<User>, LoginParams> {
  final AuthRepo authRepo;
  final UserRepo userRepo;

  Login({required this.authRepo, required this.userRepo});

  @override
  Future<Result<User>> call(LoginParams params) async {
    final idResult =
        await authRepo.login(email: params.email, password: params.password);

    if (idResult is Success) {
      final userResult =
          await userRepo.getUser(uid: idResult.resultValue ?? "");

      return switch (userResult) {
        Success(value: final user) => Result.success(user),
        Failed(message: final message) => Result.failed(message)
      };
    } else {
      return Result.failed(idResult.errorMessage ?? "Unknown Error");
    }
  }
}
