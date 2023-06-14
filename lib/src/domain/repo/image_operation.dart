import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:fitx/src/domain/model/error/error.dart';
import 'package:fitx/src/domain/model/image/image.dart';

abstract class ImageOperations {
  Future<int> imageAdd(File image);
  Future<Either<ErrorModel, List<ImageModel>>> getAllImages();
  Future<Either<ErrorModel, bool>> deleteImage(int id);
}
