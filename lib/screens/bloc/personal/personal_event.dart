part of 'personal_bloc.dart';

@immutable
abstract class PersonalEvent {}

class FetchData extends PersonalEvent {
  FetchData();
}
