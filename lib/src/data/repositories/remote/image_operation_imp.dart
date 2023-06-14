import 'dart:convert';
import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:fitx/src/data/repositories/remote/get_new_access.dart';
import 'package:fitx/src/domain/repo/image_operation.dart';
import 'package:fitx/src/domain/model/error/error.dart';
import 'package:fitx/src/domain/model/image/image.dart';
import 'package:fitx/src/domain/model/image/image_page/image_page.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../config/constants/strings.dart';

class ImageOperationsImp extends ImageOperations {
  @override
  Future<int> imageAdd(File image) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('access')!;
      var response = await addImageFunction(access, image);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.statusCode;
      } else if (response.statusCode == 401) {
        final newKey = await GetNewAccessKey.getNewAccessKey();
        if (newKey.isRight) {
          final response = await addImageFunction(newKey.right, image);
          if (response.statusCode == 200 || response.statusCode == 201) {
            return response.statusCode;
          }
        }
      }
    } on Exception catch (_) {}
    return 401;
  }

  Future<http.StreamedResponse> addImageFunction(
      String access, File image) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("${baseUrl}banner/add/"),
    );
    request.headers['Authorization'] = 'Bearer $access';
    var pic = await http.MultipartFile.fromPath(
      "image",
      image.path,
    );

    request.files.add(pic);
    var response = await request.send();
    return response;
  }

  @override
  Future<Either<ErrorModel, List<ImageModel>>> getAllImages() async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('access')!;
      Response response = await getImageHelper(access);
      if (response.statusCode == 200) {
        return Right(await imageFilterFromBody(response, access));
      } else if (response.statusCode == 401) {
        final newKey = await GetNewAccessKey.getNewAccessKey();
        if (newKey.isRight) {
          final newResponse = await getImageHelper(newKey.right);
          if (newResponse.statusCode == 200) {
            return Right(await imageFilterFromBody(newResponse, newKey.right));
          }
        } else {
          return Left(ErrorModel(newKey.left.error));
        }
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('something wrong'));
  }

  Future<Response> getImageHelper(String access) async {
    final response = await http.get(Uri.parse('${baseUrl}banner/'),
        headers: {'Authorization': 'Bearer $access'});
    return response;
  }

  @override
  Future<Either<ErrorModel, bool>> deleteImage(int id) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('access')!;
      final response = await http.delete(
          Uri.parse('${baseUrl}banner/delete/$id/'),
          headers: {'Authorization': 'Bearer $access'});
      if (response.statusCode == 204) {
        return const Right(true);
      } else if (response.statusCode == 401) {
        final newKey = await GetNewAccessKey.getNewAccessKey();
        if (newKey.isRight) {
          shrd.setString('access', newKey.right);
          final response = await http.delete(
              Uri.parse('${baseUrl}banner/delete/$id/'),
              headers: {'Authorization': 'Bearer $access'});
          if (response.statusCode == 204) {
            return const Right(true);
          } else {
            return Left(ErrorModel(response.statusCode.toString()));
          }
        }
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('something wrong'));
  }

  Future<List<ImageModel>> imageFilterFromBody(
      Response response, String access) async {
    List<ImageModel> images = [];
    while (true) {
      Map<String, dynamic> data = jsonDecode(response.body);
      ImagePage imagePage = ImagePage.fromJson(data);

      for (var element in imagePage.results ?? []) {
        ImageModel image = ImageModel.fromJson(element);
        images.add(image);
      }
      if (imagePage.next != null) {
        response = await http.get(Uri.parse(imagePage.next),
            headers: {'Authorization': 'Bearer $access'});
      } else {
        break;
      }
    }
    return images;
  }
}
