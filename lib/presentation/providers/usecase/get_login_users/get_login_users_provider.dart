import 'package:cinema_app/domain/usecases/get_login_user/get_login_user.dart';
import 'package:cinema_app/presentation/providers/repo/auth/auth_repo_provider.dart';
import 'package:cinema_app/presentation/providers/repo/user/user_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "get_login_users_provider.g.dart";

@riverpod
GetLoginUser getLoginUser(GetLoginUserRef ref) => GetLoginUser(
    authRepo: ref.watch(authRepoProvider),
    userRepo: ref.watch(userRepoProvider));
