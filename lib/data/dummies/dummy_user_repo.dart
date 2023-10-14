import 'dart:io';

import 'package:cinema_app/data/repositories/user_repo.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/entities/user.dart';

class DummyUserRepo implements UserRepo {
  @override
  Future<Result<User>> createUser(
      {required String uid,
      required String email,
      required String name,
      String? photoUrl,
      int balance = 0}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> getUser({required String uid}) async {
    await Future.delayed(const Duration(seconds: 1));
    return Result.success(
        User(uid: uid, email: "dummy@gmail.com", name: "dummy"));
  }

  @override
  Future<Result<int>> getUserBalance({required String uid}) {
    // TODO: implement getUserBalance
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateUser({required user}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateUserBalance(
      {required user, required int balance}) {
    // TODO: implement updateUserBalance
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> uploadUserPhoto(
      {required user, required File imageFile}) {
    // TODO: implement uploadUserPhoto
    throw UnimplementedError();
  }
}
