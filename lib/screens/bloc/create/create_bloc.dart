import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/screens/bloc/personal/personal_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc() : super(CreateInitial());

  @override
  Stream<CreateState> mapEventToState(
    CreateEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is Submit) {
      print(event.title);
      print(event.body);
      print(event.author);

      yield CreateLoading(loadingMessage: 'Wait a sec..', loading: false);
      await Future.delayed(const Duration(milliseconds: 3000), () {});

      try {
        final blogRef = FirebaseFirestore.instance.collection('blog');
        await blogRef.doc().set(
            {"title": event.title, "body": event.body, "author": event.author});

        BlocProvider.of<PersonalBloc>(event.context).add(FetchData());

        yield CreateSubmit(submitMessage: 'Blog Already Posted');
      } catch (e) {
        print(e);
        yield CreateError(errorMessage: e.toString());
      }
    }
  }
}
