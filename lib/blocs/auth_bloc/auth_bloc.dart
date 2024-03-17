import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String? email, password;

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LogInEvent) {
        emit(LoginLoadingState());

        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(LoginSucessState());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFalureState(
              errMessage: 'No user found for that email.',
            ));
          } else if (e.code == 'wrong-password') {
            emit(LoginFalureState(
              errMessage: 'Wrong password provided for that user.',
            ));
          } else {
            log(e.toString());
            emit(LoginFalureState(
              errMessage: e.code.toString(),
            ));
          }
        } catch (e) {
          log(e.toString());
          emit(LoginFalureState(
            errMessage: 'There was an error, Please try later !',
          ));
        }
      } else if (event is RegisterEvent) {
        emit(RegisterLoadingState());
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(RegisterSucessState());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegisterFalureState(
              errMessage: 'The password provided is too weak.',
            ));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFalureState(
              errMessage: 'The account already exists for that email.',
            ));
          } else {
            log(e.toString());
            emit(RegisterFalureState(
              errMessage: e.message.toString(),
            ));
          }
        } catch (e) {
          log(e.toString());
          emit(RegisterFalureState(
            errMessage: 'There was an error, Please try later !',
          ));
        }
      }
    });
  }
}
