import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'personal_event.dart';
part 'personal_state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  PersonalBloc() : super(PersonalInitial());

  @override
  Stream<PersonalState> mapEventToState(
    PersonalEvent event,
  ) async* {
    // TODO: implement mapEventToState

    yield PersonalLoading(loadingMessage: 'Please wait...');
    //await Future.delayed(const Duration(milliseconds: 3000), () {});

    try {
      final blog = await FirebaseFirestore.instance.collection('blog').get();
      // for (var blog in blog.docs) {
      // print(blog.data());
      blog.docs.forEach((element) {
        element.data();
        print(element.data());
        print(element.id);
      });
      yield PersonalDataFetch(blog.docs);

      //print(blog.docs);
      // print(blog.data());

      // }
    } catch (e) {
      // print(e);
      yield PersonalError(errorMessage: e.toString());
    }
  }
}
