import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fitx/src/presentation/views/image_screen/image_screen.dart';

class Mp3PickerOperations {
  static Future<File?> mp3Picker(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );
    if(result!=null){
     if(result.names[0]!.split('.').last=='mp3'){
      return File(result.paths[0]!);
     }else{
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a Mp3 file')));
     }
    }
    return null;
  }
}
