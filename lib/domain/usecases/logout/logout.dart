import 'package:cinema_app/data/repositories/auth_repo.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/usecases/usecase.dart';

class Logout implements UseCase<Result<void>, void> {
  final AuthRepo _authRepo;
  
  Logout({required AuthRepo authRepo}) : _authRepo = authRepo;

  @override
  Future<Result<void>> call(void params) async {
    return await _authRepo.logout();
  }
}
