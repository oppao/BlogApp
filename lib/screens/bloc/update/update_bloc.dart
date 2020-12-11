import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/screens/bloc/personal/personal_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(UpdateInitial());

  @override
  Stream<UpdateState> mapEventToState(
    UpdateEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is SubmitUpdate) {
      print(event.uid);
      print(event.title);
      print(event.author);
      print(event.body);

      yield UpdateLoading(loadingMessage: 'Updating...');
      await Future.delayed(const Duration(milliseconds: 3000), () {});

      try {
        final blogRef = FirebaseFirestore.instance.collection('blog');
        await blogRef.doc(event.uid).update(
            {"title": event.title, "body": event.body, "author": event.author});

        BlocProvider.of<PersonalBloc>(event.context).add(FetchData());

        yield UpdateDone(doneMessage: 'Updated');

        await Future.delayed(const Duration(milliseconds: 1000), () {});
        Navigator.pop(event.context, '/personalscreen');
      } catch (e) {
        print(e);
        yield UpdateError(errorMessage: e.toString());
      }

//for refreshing

    }
  }
}
