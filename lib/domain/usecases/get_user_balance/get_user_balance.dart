import 'package:cinema_app/data/repositories/user_repo.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/usecases/get_user_balance/get_user_balance_param.dart';
import 'package:cinema_app/domain/usecases/usecase.dart';

class GetUserBalance implements UseCase<Result<int>, GetUserBalanceParam> {
  final UserRepo _userRepo;

  GetUserBalance({required UserRepo userRepo}) : _userRepo = userRepo;
  @override
  Future<Result<int>> call(GetUserBalanceParam params) async {
    return await _userRepo.getUserBalance(uid: params.uid);
  }
}
