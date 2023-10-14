import 'package:cinema_app/domain/entities/result.dart';

abstract interface class AuthRepo {
  Future<Result<String>> register({required String email, required password});
  Future<Result<String>> login({required String email, required password});
  Future<Result<void>> logout();
  String getLoggedInUserId();
}
