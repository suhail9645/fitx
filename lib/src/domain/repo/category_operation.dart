import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:fitx/src/domain/model/error/error.dart';
import 'package:flutter/material.dart';
import '../model/category/category.dart';

abstract class CategoryOperation {
  Future<Either<ErrorModel, bool>> categoryAdd(
      List<TextEditingController> controllers,
      File image,
      File music,
      List<int> ids);
  Future<Either<ErrorModel, List<CategoryModel>>> getAllCategories();
  Future<Either<ErrorModel, bool>> deleteCategory(int id);
  Future<Either<ErrorModel, bool>> updateCategory(
      List<TextEditingController> controllers,
      int id,
      File? image,
      File? music,
      List<int> ids);
}
