import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_blog_event.dart';
part 'create_blog_state.dart';

class CreateBlogBloc extends Bloc<CreateBlogEvent, CreateBlogState> {
  CreateBlogBloc() : super(CreateBlogInitial());

  @override
  Stream<CreateBlogState> mapEventToState(
    CreateBlogEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
