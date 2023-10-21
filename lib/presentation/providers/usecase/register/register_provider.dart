import 'package:cinema_app/domain/usecases/register/register.dart';
import 'package:cinema_app/presentation/providers/repo/auth/auth_repo_provider.dart';
import 'package:cinema_app/presentation/providers/repo/user/user_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_provider.g.dart';

@riverpod
Register register(RegisterRef ref) => Register(
    userRepo: ref.watch(userRepoProvider),
    authRepo: ref.watch(authRepoProvider));
