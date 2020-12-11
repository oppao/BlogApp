part of 'update_bloc.dart';

@immutable
abstract class UpdateEvent {}

class SubmitUpdate extends UpdateEvent {
  final String uid, title, body, author;
  BuildContext context;

  SubmitUpdate({this.uid, this.title, this.body, this.author, this.context});
}
