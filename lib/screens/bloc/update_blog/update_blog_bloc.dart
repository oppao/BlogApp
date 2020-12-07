import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_blog_event.dart';
part 'update_blog_state.dart';

class UpdateBlogBloc extends Bloc<UpdateBlogEvent, UpdateBlogState> {
  UpdateBlogBloc() : super(UpdateBlogInitial());

  @override
  Stream<UpdateBlogState> mapEventToState(
    UpdateBlogEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
