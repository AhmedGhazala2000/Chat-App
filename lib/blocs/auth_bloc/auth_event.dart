part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LogInEvent extends AuthEvent {
  final String email, password;

  LogInEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String email, password;

  RegisterEvent({required this.email, required this.password});
}
