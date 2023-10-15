import 'package:cinema_app/data/repositories/user_repo.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/entities/user.dart';
import 'package:cinema_app/domain/usecases/upload_photo/upload_photo_param.dart';
import 'package:cinema_app/domain/usecases/usecase.dart';

class UploadPhoto implements UseCase<Result<User>, UploadPhotoParam> {
  final UserRepo _userRepo;

  UploadPhoto({required UserRepo userRepo}) : _userRepo = userRepo;

  @override
  Future<Result<User>> call(UploadPhotoParam params) async {
    return await _userRepo.uploadUserPhoto(
        user: params.user, imageFile: params.imageFile);
  }
}
