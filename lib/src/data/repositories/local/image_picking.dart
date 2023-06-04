import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickingFunction{
  static Future<File?>imagePicking()async{
   final image=await ImagePicker().pickImage(source: ImageSource.gallery);
   if(image==null){
    return null;
   }
   final croppedImage=await ImageCropper().cropImage(sourcePath: image.path);
   return File(croppedImage!.path);
  }
}