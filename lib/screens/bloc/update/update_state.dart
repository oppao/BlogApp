part of 'update_bloc.dart';

@immutable
abstract class UpdateState {}

class UpdateInitial extends UpdateState {}

class UpdateLoading extends UpdateState {
  final String loadingMessage;

  UpdateLoading({this.loadingMessage});
}

class UpdateDone extends UpdateState {
  final String doneMessage;

  UpdateDone({this.doneMessage});
}

class UpdateError extends UpdateState {
  final String errorMessage;

  UpdateError({this.errorMessage});
}
