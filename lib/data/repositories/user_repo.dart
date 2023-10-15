import 'dart:io';

import 'package:cinema_app/domain/entities/user.dart';

import '../../domain/entities/result.dart';

abstract interface class UserRepo {
  Future<Result<User>> createUser(
      {required String uid,
      required String email,
      required String name,
      String? photoUrl,
      int balance = 0});

  Future<Result<User>> getUser({required String uid});
  Future<Result<User>> updateUser({required User user});
  Future<Result<int>> getUserBalance({required String uid});
  Future<Result<User>> updateUserBalance(
      {required String uid, required int balance});
  Future<Result<User>> uploadUserPhoto(
      {required User user, required File imageFile});
}
