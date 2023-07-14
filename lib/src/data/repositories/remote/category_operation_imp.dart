import 'dart:convert';
import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:fitx/src/data/repositories/remote/exercise_operation_imp.dart';
import 'package:fitx/src/data/repositories/remote/get_new_access.dart';
import 'package:fitx/src/domain/model/category/category.dart';
import 'package:fitx/src/domain/model/error/error.dart';
import 'package:fitx/src/domain/model/exercise/exercise.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/constants/strings.dart';
import '../../../domain/model/category/category_page/category_page.dart';
import '../../../domain/repo/category_operation.dart';
import 'package:http/http.dart' as http;

class CategoryOperationImp extends CategoryOperation {
  @override
  Future<Either<ErrorModel, bool>> categoryAdd(
      List<TextEditingController> controllers,
      File image,
      File music,
      List<int> ids) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('access')!;
      StreamedResponse response =
          await addCategoryHelper(image, music, controllers, access, ids);
      if (response.statusCode == 201) {
        return const Right(true);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          response = await addCategoryHelper(
              image, music, controllers, newAccess.right, ids);
          if (response.statusCode == 201) {
            return const Right(true);
          }
        }
      }
    } on Exception catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('session Expired'));
  }

  Future<StreamedResponse> addCategoryHelper(
      File image,
      File music,
      List<TextEditingController> controllers,
      String access,
      List<int> ids) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}category/create/"),
    );
    request.headers.addAll({
      'Authorization': 'Bearer $access',
      'Content-type': 'multipart/form-data'
    });
    var pic = await http.MultipartFile.fromPath(
      "image",
      image.path,
    );
    var song = await http.MultipartFile.fromPath(
      "music",
      music.path,
    );
    request.files.addAll({pic, song});

    request.fields.addAll({
      "name": controllers[0].text,
      "description": controllers[1].text,
    });
    StreamedResponse res = await request.send();

    if (res.statusCode == 201) {
      Response response = await http.Response.fromStream(res);
      Map<String, dynamic> data = jsonDecode(response.body);
      CategoryModel categoryModel = CategoryModel.fromJson(data);
      for (var element in ids) {
        await http.patch(
            Uri.parse('${baseUrl}category/${categoryModel.id}/add/$element/'),
            headers: {
              'Authorization': 'Bearer $access',
            });
      }
    }
    return res;
  }

  @override
  Future<Either<ErrorModel, List<CategoryModel>>> getAllCategories() async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('access')!;
      Response response =
          await http.get(Uri.parse('${baseUrl}category/getall/'), headers: {
        'Authorization': 'Bearer $access',
      });
      if (response.statusCode == 200) {
        List<CategoryModel> categories =
            await filterCategoriesfromBody(response, access);
        for (var element in categories) {
          Response exerciseResponse = await http.get(
              Uri.parse('${baseUrl}exercise/category/${element.id}/'),
              headers: {
                'Authorization': 'Bearer $access',
              });
          if (exerciseResponse.statusCode == 200) {
            element.exercises = await ExerciseOperationsImp()
                .exerciseFilterFromBody(exerciseResponse, access);
          }
        }
        return Right(categories);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          response =
              await http.get(Uri.parse('${baseUrl}category/getall/'), headers: {
            'Authorization': 'Bearer ${newAccess.right}',
          });
          if (response.statusCode == 200) {
            List<CategoryModel> categories =
                await filterCategoriesfromBody(response, newAccess.right);
            for (var element in categories) {
              Response exerciseResponse = await http.get(
                  Uri.parse('${baseUrl}exercise/category/${element.id}/'),
                  headers: {
                    'Authorization': 'Bearer $access',
                  });
              if (exerciseResponse.statusCode == 200) {
                element.exercises = await ExerciseOperationsImp()
                    .exerciseFilterFromBody(exerciseResponse, access);
              }
            }

            return Right(categories);
          }
        }
      }
    } on Exception catch (e) {
      Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('session expired'));
  }

  Future<List<CategoryModel>> filterCategoriesfromBody(
      Response response, String access) async {
    List<CategoryModel> categories = [];
    while (true) {
      Map<String, dynamic> data = jsonDecode(response.body);
      CategoryModelPage categoryPage = CategoryModelPage.fromJson(data);

      for (var element in categoryPage.results ?? []) {
        CategoryModel categoryModel = CategoryModel.fromJson(element);
        categories.add(categoryModel);
      }
      if (categoryPage.next != null) {
        response = await http.get(Uri.parse(categoryPage.next),
            headers: {'Authorization': 'Bearer $access'});
      } else {
        break;
      }
    }

    return categories;
  }

  @override
  Future<Either<ErrorModel, bool>> deleteCategory(int id) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('access')!;
      Response response = await http.delete(
          Uri.parse('${baseUrl}category/delete/$id/'),
          headers: {'Authorization': 'Bearer $access'});
      if (response.statusCode == 204) {
        return const Right(true);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          response = await http.delete(
              Uri.parse('${baseUrl}category/delete/$id/'),
              headers: {'Authorization': 'Bearer ${newAccess.right}'});
          if (response.statusCode == 204) {
            return const Right(true);
          }
        }
      }
    } on Exception catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('session expired'));
  }

  @override
  Future<Either<ErrorModel, bool>> updateCategory(
      List<TextEditingController> controllers,
      int id,
      File? image,
      File? music,
      List<int> ids) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('access')!;
      StreamedResponse response = await updateCategoryHelper(
          image, music, id, controllers, access, ids);
      if (response.statusCode == 200) {
        return const Right(true);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          response = await updateCategoryHelper(
              image, music, id, controllers, newAccess.right, ids);
          if (response.statusCode == 200) {
            return const Right(true);
          }
        }
      }
    } on Exception catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('session expired'));
  }

  Future<StreamedResponse> updateCategoryHelper(
      File? image,
      File? music,
      int id,
      List<TextEditingController> controllers,
      String access,
      List<int> ids) async {
    final request = http.MultipartRequest(
      'PATCH',
      Uri.parse("${baseUrl}category/update/$id/"),
    );
    request.headers.addAll({
      'Authorization': 'Bearer $access',
      'Content-type': 'multipart/form-data'
    });
    if (image != null) {
      var pic = await http.MultipartFile.fromPath(
        "image",
        image.path,
      );
      request.files.add(pic);
    }
    if (music != null) {
      var song = await http.MultipartFile.fromPath(
        "music",
        music.path,
      );
      request.files.add(song);
    }

    request.fields.addAll({
      "name": controllers[0].text,
      "description": controllers[1].text,
    });
    StreamedResponse res = await request.send();

    if (res.statusCode == 200) {
      Response exerciseResponse = await http
          .get(Uri.parse('${baseUrl}exercise/category/$id/'), headers: {
        'Authorization': 'Bearer $access',
      });
      List<Exercise> exercises = await ExerciseOperationsImp()
          .exerciseFilterFromBody(exerciseResponse, access);

      for (var element in exercises) {
        await http.patch(
            Uri.parse('${baseUrl}category/$id/remove/${element.id}/'),
            headers: {
              'Authorization': 'Bearer $access',
            });
      }
      for (var element in ids) {
        await http
            .patch(Uri.parse('${baseUrl}category/$id/add/$element/'), headers: {
          'Authorization': 'Bearer $access',
        });
      }
    }
    return res;
  }
}
