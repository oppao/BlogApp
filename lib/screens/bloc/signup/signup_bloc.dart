import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial());

  final _auth = FirebaseAuth.instance;

  get onPressed => null;

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is CreateAccount) {
      print(event.email);
      print(event.password);
      yield SignupLoading(loadingMessage: 'Please wait...');
      await Future.delayed(const Duration(milliseconds: 3000), () {});

      try {
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: event.email, password: event.password);

        if (newUser != null) {
          print('Account created');

          yield SignupDone(doneMessage: 'Account Created');
        }
      } catch (e) {
        print(e);
        yield SignupError(errorMessage: e.toString());
      }
    }
  }
}
