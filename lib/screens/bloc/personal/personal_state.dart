part of 'personal_bloc.dart';

@immutable
abstract class PersonalState {}

class PersonalInitial extends PersonalState {}

class PersonalLoading extends PersonalState {
  final String loadingMessage;

  PersonalLoading({this.loadingMessage});
}

class PersonalDataFetch extends PersonalState {
  final List blog;

  PersonalDataFetch(this.blog);
}

class PersonalDone extends PersonalState {
  final String doneMessage;

  PersonalDone({this.doneMessage});
}

class PersonalError extends PersonalState {
  final String errorMessage;

  PersonalError({this.errorMessage});
}
