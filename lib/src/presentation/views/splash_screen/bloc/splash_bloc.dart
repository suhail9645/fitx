import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashInitialEvent>(splashInitialEvent);
  }

  FutureOr<void> splashInitialEvent(
      SplashInitialEvent event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 3));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isLogin = preferences.getString('access')?.isNotEmpty;
    if (isLogin == true) {
      emit(AdminLoginState());
    } else {
      emit(AdminLogoutState());
    }
  }
}
