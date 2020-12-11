import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../personal/personal_bloc.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  DeleteBloc() : super(DeleteInitial());

  @override
  Stream<DeleteState> mapEventToState(
    DeleteEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is Delete) {
      print(event.uid.toString());

      yield DeleteLoading(loadingMessage: 'Deleting...');
      await Future.delayed(const Duration(milliseconds: 3000), () {});

      try {
        final blogRef = FirebaseFirestore.instance.collection('blog');

        await blogRef.doc(event.uid).delete();

        BlocProvider.of<PersonalBloc>(event.context).add(FetchData());
        yield DeleteDone(doneMessage: 'Deleted Successfully');
      } catch (e) {
        print(e);
        yield DeleteError(errorMessage: e.toString());
      }
    }
  }
}
