import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fitx/src/data/repositories/local/image_picking.dart';
import 'package:meta/meta.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<AddImageButtonClickedEvent>(addImageButtonClickedEvent);
  }

  FutureOr<void> addImageButtonClickedEvent(AddImageButtonClickedEvent event, Emitter<ImageState> emit)async {
    File?image=await ImagePickingFunction.imagePicking();
    if(image!=null){
      emit(AddImageState(image));
    }
  }
}
