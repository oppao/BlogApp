part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class CreateAccount extends SignupEvent {
  final String email, password;

  CreateAccount({this.email, this.password});
}
