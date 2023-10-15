import 'package:cinema_app/data/repositories/auth_repo.dart';
import 'package:cinema_app/data/repositories/user_repo.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/entities/user.dart';
import 'package:cinema_app/domain/usecases/usecase.dart';

class GetLoginUser implements UseCase<Result<User>, void> {
  final AuthRepo _authRepo;
  final UserRepo _userRepo;

  GetLoginUser({required AuthRepo authRepo, required UserRepo userRepo})
      : _authRepo = authRepo,
        _userRepo = userRepo;
  @override
  Future<Result<User>> call(void params) async {
    final uid = _authRepo.getLoggedInUserId();
    if (uid != null) {
      return await _userRepo.getUser(uid: uid);
    } else {
      return const Failed("No User Login Yet");
    }
  }
}
