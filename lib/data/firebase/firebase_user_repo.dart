import 'dart:io';

import 'package:cinema_app/data/repositories/user_repo.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseUserRepo implements UserRepo {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseUserRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<Result<User>> createUser(
      {required String uid,
      required String email,
      required String name,
      String? photoUrl,
      int balance = 0}) async {
    try {
      CollectionReference<Map<String, dynamic>> users =
          _firebaseFirestore.collection("users");
      final user = User(uid: uid, email: email, name: name);
      await users.doc(uid).set(user.toJson());

      DocumentSnapshot<Map<String, dynamic>> result =
          await users.doc(uid).get();
      if (result.exists) {
        return Result.success(User.fromJson(result.data()!));
      } else {
        return const Result.failed("Failed To Create User");
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? "Unknow Error");
    }
  }

  @override
  Future<Result<User>> getUser({required String uid}) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          _firebaseFirestore.doc("users/$uid");

      DocumentSnapshot<Map<String, dynamic>> result =
          await documentReference.get();

      if (result.exists) {
        return Result.success(User.fromJson(result.data()!));
      } else {
        return const Result.failed("Users  Not Found");
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? "Unknow Error");
    }
  }

  @override
  Future<Result<int>> getUserBalance({required String uid}) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          _firebaseFirestore.doc("users/$uid");

      DocumentSnapshot<Map<String, dynamic>> result =
          await documentReference.get();

      if (result.exists) {
        return Result.success(User.fromJson(result.data()!).balance);
      } else {
        return const Result.failed("Users  Not Found");
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? "Unknow Error");
    }
  }

  @override
  Future<Result<User>> updateUser({required User user}) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          _firebaseFirestore.doc("users/${user.uid}");
      documentReference.update(user.toJson());

      DocumentSnapshot<Map<String, dynamic>> result =
          await documentReference.get();

      if (result.exists) {
        return Result.success(user);
      } else {
        return const Result.failed("Failed Update user");
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? "Unknow Error");
    }
  }

  @override
  Future<Result<User>> updateUserBalance(
      {required String uid, required int balance}) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          _firebaseFirestore.doc("users/$uid");

      DocumentSnapshot<Map<String, dynamic>> result =
          await documentReference.get();

      if (result.exists) {
        documentReference.update({'balance': balance});
        DocumentSnapshot<Map<String, dynamic>> updateResult =
            await documentReference.get();
        if (updateResult.exists) {
          final updateUser = User.fromJson(updateResult.data()!);
          if (updateUser.balance == balance) {
            return Result.success(updateUser);
          } else {
            return const Result.failed("Failed To Update Balance");
          }
        } else {
          return const Result.failed("User Not Found");
        }
      } else {
        return const Result.failed("Failed To Retrieve Update Data");
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? "Unknow Error");
    }
  }

  @override
  Future<Result<User>> uploadUserPhoto(
      {required User user, required File imageFile}) async {
    String fileName = basename(imageFile.path);
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    try {
      await reference.putFile(imageFile);
      String downloadUrl = await reference.getDownloadURL();

      final updateResult =
          await updateUser(user: user.copyWith(photo: downloadUrl));
      if (updateResult is Success) {
        return Result.success(updateResult.resultValue!);
      } else {
        return Result.failed(updateResult.errorMessage!);
      }
    } catch (e) {
      return const Result.failed("Failed to upload profile picture");
    }
  }
}
