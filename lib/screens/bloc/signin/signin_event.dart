part of 'signin_bloc.dart';

@immutable
abstract class SigninEvent {}

class Submit extends SigninEvent {
  final String email, password;

  Submit({this.email, this.password});
}
