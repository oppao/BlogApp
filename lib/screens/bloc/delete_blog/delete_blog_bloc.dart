import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_blog_event.dart';
part 'delete_blog_state.dart';

class DeleteBlogBloc extends Bloc<DeleteBlogEvent, DeleteBlogState> {
  DeleteBlogBloc() : super(DeleteBlogInitial());

  @override
  Stream<DeleteBlogState> mapEventToState(
    DeleteBlogEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
