part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoadingState extends AuthState {}

final class LoginSucessState extends AuthState {}

final class LoginFalureState extends AuthState {
  final String errMessage;
  LoginFalureState({required this.errMessage});
}

final class RegisterLoadingState extends AuthState {}

final class RegisterSucessState extends AuthState {}

final class RegisterFalureState extends AuthState {
  final String errMessage;
  RegisterFalureState({required this.errMessage});
}
