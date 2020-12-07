import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitial());
  final _auth = FirebaseAuth.instance;

  @override
  Stream<SigninState> mapEventToState(
    SigninEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is Submit) {
      print(event.email);
      print(event.password);
      yield SigninLoading(loadingMessage: 'Please wait...');
      await Future.delayed(const Duration(milliseconds: 3000), () {});

      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: event.email, password: event.password);

        if (user != null) {
          print('pasok na');
          yield SigninSubmit(submitMessage: 'Login Successfully');
        }
      } catch (e) {
        print(e);
        yield SigninError(errorMessage: e.toString());
      }
    }
  }
}
