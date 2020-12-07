part of 'signin_bloc.dart';

@immutable
abstract class SigninState {}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {
  final String loadingMessage;

  SigninLoading({this.loadingMessage});
}

class SigninSubmit extends SigninState {
  final String submitMessage;

  SigninSubmit({this.submitMessage});
}

class SigninError extends SigninState {
  final String errorMessage;

  SigninError({this.errorMessage});
}
