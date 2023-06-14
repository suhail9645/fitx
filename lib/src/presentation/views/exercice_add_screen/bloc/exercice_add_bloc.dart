import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fitx/src/config/constants/lists.dart';
import 'package:fitx/src/data/repositories/local/image_picking.dart';
import 'package:meta/meta.dart';

part 'exercice_add_event.dart';
part 'exercice_add_state.dart';

class ExerciceAddBloc extends Bloc<ExerciceAddEvent, ExerciceAddState> {
  ExerciceAddBloc()
      : super(ExerciceAddInitial(null,gif: null, groupValue: 'Count',)) {
    on<GifAddEvent>(gifAddEvent);
    on<TimeAndCountChangeEvent>(timeAndCountChangeEvent);
    on<ExerciseAddSuccess>(exerciseAddSuccess);
    on<ExerciseEditEvent>(exerciseEditEvent);
  }

  FutureOr<void> gifAddEvent(
      GifAddEvent event, Emitter<ExerciceAddState> emit) async {
    final gif = await ImagePickingFunction.imagePicking();
    if (gif != null) {
      emit(ExerciceAddInitial(null,gif: gif, groupValue: event.groupValue,));
    }
  }

  FutureOr<void> timeAndCountChangeEvent(
      TimeAndCountChangeEvent event, Emitter<ExerciceAddState> emit) {
    emit(ExerciceAddInitial(null,gif: event.gif, groupValue: event.groupValue));
  }

  FutureOr<void> exerciseAddSuccess(
      ExerciseAddSuccess event, Emitter<ExerciceAddState> emit) {
    for (var element in exerciceAddPageTextEditingControllers) {
      element.clear();
    }
    emit(ExerciceAddInitial(null, gif: null, groupValue: 'Count'));
  }

  FutureOr<void> exerciseEditEvent(ExerciseEditEvent event, Emitter<ExerciceAddState> emit) {
     emit(ExerciceAddInitial(event.image, gif: null, groupValue: event.groupValue));
  }
}
