import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fitx/src/config/constants/lists.dart';
import 'package:meta/meta.dart';
import '../../../../data/repositories/local/image_picking.dart';
part 'categoryadd_event.dart';
part 'categoryadd_state.dart';

class CategoryaddBloc extends Bloc<CategoryaddEvent, CategoryaddState> {
  CategoryaddBloc() : super(CategoryaddInitial()) {
    on<AddImageCategoryEvent>(addImageEvent);
    on<SaveSuccessCategoryEvent>(saveSuccessCategoryEvent);
  }

  FutureOr<void> addImageEvent(
      AddImageCategoryEvent event, Emitter<CategoryaddState> emit) async {
    File? image = await ImagePickingFunction.imagePicking();
    if (image != null) {
      emit(AddImageState(image: image));
    }
  }

  FutureOr<void> saveSuccessCategoryEvent(SaveSuccessCategoryEvent event, Emitter<CategoryaddState> emit) {
    for (var element in categoryAddPageTextEditingControllers) {
      element.clear();
    }
    emit(CategoryaddInitial());
  }
}
