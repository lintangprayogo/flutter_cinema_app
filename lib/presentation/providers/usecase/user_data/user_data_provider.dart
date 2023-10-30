import 'dart:io';

import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/entities/user.dart';
import 'package:cinema_app/domain/usecases/get_login_user/get_login_user.dart';
import 'package:cinema_app/domain/usecases/login/login.dart';
import 'package:cinema_app/domain/usecases/login/login_params.dart';
import 'package:cinema_app/domain/usecases/logout/logout.dart';
import 'package:cinema_app/domain/usecases/register/register.dart';
import 'package:cinema_app/domain/usecases/register/register_param.dart';
import 'package:cinema_app/domain/usecases/top_up/top_up.dart';
import 'package:cinema_app/domain/usecases/top_up/top_up_param.dart';
import 'package:cinema_app/domain/usecases/upload_photo/upload_photo.dart';
import 'package:cinema_app/domain/usecases/upload_photo/upload_photo_param.dart';
import 'package:cinema_app/presentation/providers/movie/now_playing/now_playing_provider.dart';
import 'package:cinema_app/presentation/providers/movie/upcoming/upcoming_provider.dart';
import 'package:cinema_app/presentation/providers/usecase/get_login_users/get_login_users_provider.dart';
import 'package:cinema_app/presentation/providers/usecase/login/login_provider.dart';
import 'package:cinema_app/presentation/providers/usecase/logout/logout_prodiver.dart';
import 'package:cinema_app/presentation/providers/usecase/register/register_provider.dart';
import 'package:cinema_app/presentation/providers/usecase/top_up/top_up_provider.dart';
import 'package:cinema_app/presentation/providers/usecase/transaction/transaction_data_provider.dart';
import 'package:cinema_app/presentation/providers/usecase/upload_photo/upload_photo_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async {
    GetLoginUser getLoginUser = ref.read(getLoginUserProvider);
    final result = await getLoginUser.call(null);
    switch (result) {
      case Success(value: final user):
        _getMovies();
        return user;
      case Failed(errorMessage: _):
        return null;
    }
  }

  Future<void> login({required String email, required password}) async {
    state = const AsyncLoading();

    Login login = ref.read(loginProvider);
    final result =
        await login.call(LoginParams(email: email, password: password));

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);
      case Failed(errorMessage: final msg):
        state = AsyncError(
            FlutterError(msg ?? "unknown error"), StackTrace.current);
    }
  }

  Future<void> register({
    required String email,
    required String name,
    required String password,
    String? photo,
  }) async {
    state = const AsyncLoading();

    Register register = ref.read(registerProvider);

    var result = await register(RegisterParam(
        email: email, name: name, password: password, photoUrl: photo));

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> refreshUserData() async {
    GetLoginUser getLoggedInUser = ref.read(getLoginUserProvider);

    var result = await getLoggedInUser(null);

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  Future<void> logout() async {
    Logout login = ref.read(logoutProvider);
    final result = await login.call(null);

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }

  Future<void> topUp(int amount) async {
    String? uid = state.valueOrNull?.uid;
    TopUp topUp = ref.read(topUpProvider);

    if (uid != null) {
      final result = topUp.call(TopUpParam(amount: amount, uid: uid));
      switch (result) {
        case Success(value: _):
          refreshUserData();
          ref.read(transactionDataProvider.notifier).refreshTransactionData();

        case Failed(errorMessage: final msg):
          state = AsyncError(FlutterError(msg!), StackTrace.current);
          state = AsyncData(state.valueOrNull);
      }
    }
  }

  Future<void> uploadProfilePicture(
      {required User user, required File imageFile}) async {
    UploadPhoto uploadPhoto = ref.read(uploadPhotoProvider);

    var result =
        await uploadPhoto(UploadPhotoParam(imageFile: imageFile, user: user));

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  void _getMovies() {
    ref.read(nowPlayingProvider.notifier).getMovies();
    ref.read(upcomingProvider.notifier).getMovies();
  }
}
