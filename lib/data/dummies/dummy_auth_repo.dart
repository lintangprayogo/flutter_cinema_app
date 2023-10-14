import 'package:cinema_app/data/repositories/auth_repo.dart';
import 'package:cinema_app/domain/entities/result.dart';

class DummyAuthRepo implements AuthRepo {
  @override
  String getLoggedInUserId() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> login(
      {required String email, required password}) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Result.success("ID-12345");
  }

  @override
  Future<Result<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> register({required String email, required password}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
