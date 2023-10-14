import 'package:cinema_app/data/firebase/firebase_auth_repo.dart';
import 'package:cinema_app/data/repositories/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repo_provider.g.dart';

@riverpod
AuthRepo authRepo(AuthRepoRef ref) => FireBaseAuthRepo();
