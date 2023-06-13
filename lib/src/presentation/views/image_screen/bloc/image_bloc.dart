import 'dart:async';
import 'dart:io';
import 'package:fitx/main.dart';
import 'package:fitx/src/data/repositories/remote/image/image_operation_imp.dart';
import 'package:fitx/src/presentation/views/image_screen/bloc/add_image_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../../../domain/model/image/image.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<ImageInitialEvent>(imageInitialEvent);
    on<SaveImageButtonClickedEvent>(saveImageButtonClickedEvent);
    on<ImageDeleteEvent>(imageDeleteEvent);
  }

  FutureOr<void> imageInitialEvent(
      ImageInitialEvent event, Emitter<ImageState> emit) async {
    emit(ImageLoadingState());
    final resuslt = await ImageOperationsImp().getAllImages();
    if (resuslt.isRight) {
      emit(ImageInitialState(images: resuslt.right));
    } else {
      emit(SaveImageErrorState());
    }
  }

  FutureOr<void> saveImageButtonClickedEvent(
      SaveImageButtonClickedEvent event, Emitter<ImageState> emit) async {
    final statusCode = await ImageOperationsImp().imageAdd(event.image);
    if (statusCode == 200 || statusCode == 201) {
      imageBloc.add(ImageInitialEvent());
      addImageBloc.add(AfterSaveImageEvent());
    } else {
      emit(SaveImageErrorState());
    }
  }

  FutureOr<void> imageDeleteEvent(
      ImageDeleteEvent event, Emitter<ImageState> emit) async {
    final response = await ImageOperationsImp().deleteImage(event.id);
    if (response.isRight) {
      emit(DeleteImageSuccess());
      imageBloc.add(ImageInitialEvent());
    } else {}
  }
}
