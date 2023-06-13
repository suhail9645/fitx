import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial(index: 0));
  void onTapFunctionOfBottemNavigationBar(int index) {
    emit(HomeInitial(index: index));
  }
}
