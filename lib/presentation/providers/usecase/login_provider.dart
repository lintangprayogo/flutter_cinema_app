import 'package:cinema_app/domain/usecases/login/login.dart';
import 'package:cinema_app/presentation/providers/repo/auth/auth_repo_provider.dart';
import 'package:cinema_app/presentation/providers/repo/user/user_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
Login login(LoginRef ref) => Login(
    authRepo: ref.watch(authRepoProvider),
    userRepo: ref.watch(userRepoProvider));
