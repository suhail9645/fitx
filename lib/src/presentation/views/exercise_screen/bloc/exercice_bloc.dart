import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'exercice_event.dart';
part 'exercice_state.dart';

class ExerciceBloc extends Bloc<ExerciceEvent, ExerciceState> {
  ExerciceBloc() : super(ExerciceInitial()) {
    on<ExerciceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
