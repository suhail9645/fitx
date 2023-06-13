part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonClicked extends LoginEvent {
  final String userName;
  final String password;

  LoginButtonClicked({required this.userName, required this.password});
}
