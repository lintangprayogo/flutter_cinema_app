import 'package:cinema_app/domain/usecases/logout/logout.dart';
import 'package:cinema_app/presentation/providers/repo/auth/auth_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'logout_prodiver.g.dart';

@riverpod
Logout logout(LogoutRef ref) => Logout(authRepo: ref.watch(authRepoProvider));
