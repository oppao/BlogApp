part of 'delete_bloc.dart';

@immutable
abstract class DeleteState {}

class DeleteInitial extends DeleteState {}

class DeleteLoading extends DeleteState {
  final String loadingMessage;
  final List deleteBlog;

  DeleteLoading({this.deleteBlog, this.loadingMessage});
}

class DeleteDone extends DeleteState {
  final String doneMessage;

  DeleteDone({this.doneMessage});
}

class DeleteError extends DeleteState {
  final String errorMessage;

  DeleteError({this.errorMessage});
}
