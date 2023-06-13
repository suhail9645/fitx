import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<AdminLogoutEvent>(adminLogoutEvent);
  }

  FutureOr<void> adminLogoutEvent(
      AdminLogoutEvent event, Emitter<AdminState> emit) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('admin', false);
  }
}
