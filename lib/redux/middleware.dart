import 'dart:async';


import 'package:redux/redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firedux/redux/actions.dart';
import 'package:firedux/redux/app_state.dart';

StreamSubscription<DocumentSnapshot> _ref;

Middleware<AppState> _iniializeCounter(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) {
    _ref = Firestore.instance.document('counts/test').snapshots().listen(
      (DocumentSnapshot doc) {
        store.dispatch(SetCounterAction(doc.data['count']));
      }
    );
  };
}

Middleware<AppState> _cancelCounter(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) {
    _ref.cancel();
  };
}

List<Middleware<AppState>> appStateMiddleware([
  AppState state = const AppState(counter: 0),
]) {

  final initializeCounter = _iniializeCounter(state);
  final cancelCounter = _cancelCounter(state);

  return [
    TypedMiddleware<AppState, InitializeCounterAction>(initializeCounter),
    TypedMiddleware<AppState, CancelCounterAction>(cancelCounter),
  ];
}
