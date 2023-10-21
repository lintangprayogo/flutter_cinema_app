import 'package:cinema_app/domain/usecases/upload_photo/upload_photo.dart';
import 'package:cinema_app/presentation/providers/repo/user/user_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'upload_photo_provider.g.dart';

@riverpod
UploadPhoto uploadPhoto(UploadPhotoRef ref) =>
    UploadPhoto(userRepo: ref.read(userRepoProvider));
