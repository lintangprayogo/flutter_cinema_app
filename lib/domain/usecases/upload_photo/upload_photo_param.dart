import 'dart:io';

import 'package:cinema_app/domain/entities/user.dart';

class UploadPhotoParam {
  final File imageFile;
  final User user;

  UploadPhotoParam({required this.imageFile, required this.user});
}
