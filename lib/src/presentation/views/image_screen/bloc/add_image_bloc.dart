import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../data/repositories/local/image_picking.dart';
part 'add_image_event.dart';
part 'add_image_state.dart';

class AddImageBloc extends Bloc<AddImageEvent, AddImageState> {
  AddImageBloc() : super(AddImageInitial()) {
    on<AddImageButtonClickedEvent>(addImageButtonClickedEvent);
    on<AfterSaveImageEvent>(afterSaveImageEvent);
  }
  FutureOr<void> addImageButtonClickedEvent(
      AddImageButtonClickedEvent event, Emitter<AddImageState> emit) async {
    File? image = await ImagePickingFunction.imagePicking();
    if (image != null) {
      emit(AfterImageState(image: image));
    }
  }

  FutureOr<void> afterSaveImageEvent(
      AfterSaveImageEvent event, Emitter<AddImageState> emit) {
    emit(AfterImageSavedState());
  }
}
