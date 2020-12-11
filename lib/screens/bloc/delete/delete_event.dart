part of 'delete_bloc.dart';

@immutable
abstract class DeleteEvent {
  Object get uid => null;
}

class Delete extends DeleteEvent {
  var uid;
  BuildContext context;

  Delete({this.uid, this.context});
}
