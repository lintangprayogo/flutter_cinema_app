import 'package:cinema_app/data/firebase/firebase_user_repo.dart';
import 'package:cinema_app/data/repositories/user_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repo_provider.g.dart';

@riverpod
UserRepo userRepo(UserRepoRef ref) => FirebaseUserRepo();
