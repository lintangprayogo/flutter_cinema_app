import 'package:cinema_app/data/repositories/auth_repo.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class FireBaseAuthRepo implements AuthRepo {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FireBaseAuthRepo({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  String? getLoggedInUserId() => _firebaseAuth.currentUser?.uid;

  @override
  Future<Result<String>> login(
      {required String email, required password}) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Result.success(userCredential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Result.failed(e.message ?? "Unknown Error");
    }
  }

  @override
  Future<Result<void>> logout() async {
    await _firebaseAuth.signOut();
    if (getLoggedInUserId() == null) {
      return const Success(null);
    } else {
      return const Result.failed("Logout Failed");
    }
  }

  @override
  Future<Result<String>> register({required String email, required password}) async {
   try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Result.success(userCredential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Result.failed(e.message ?? "Unknown Error");
    }
  }
}
