import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fitx/src/data/repositories/remote/admin/admin_login_imp.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonClicked>(loginButtonClicked);
  }

  FutureOr<void> loginButtonClicked(
      LoginButtonClicked event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    bool isAdmin =
        await AdminLoginFunctionsImp().isAdmin(event.userName, event.password);
    if (isAdmin) {
      emit(LoginSuccessState());
    } else {
      emit(LoginErrorState());
    }
  }
}
