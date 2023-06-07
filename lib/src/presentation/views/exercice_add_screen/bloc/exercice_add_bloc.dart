import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fitx/src/data/repositories/local/image_picking.dart';
import 'package:meta/meta.dart';

part 'exercice_add_event.dart';
part 'exercice_add_state.dart';

class ExerciceAddBloc extends Bloc<ExerciceAddEvent, ExerciceAddState> {
  ExerciceAddBloc() : super(ExerciceAddInitial()) {
  on<GifAddEvent>(gifAddEvent);
  }

  FutureOr<void> gifAddEvent(GifAddEvent event, Emitter<ExerciceAddState> emit)async {
    final gif=await ImagePickingFunction.imagePicking();
    if(gif!=null){
      emit(GifAddState(gif: gif));
    }
  }
}
