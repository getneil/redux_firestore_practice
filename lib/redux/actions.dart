import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:firedux/redux/app_state.dart';

class IncrementCounterAction {}


class RequestCounterDataEventsAction {}

class CancelCounterDataEventsAction {}

class CounterOnDataEventAction {
  final int counter;

  CounterOnDataEventAction(this.counter);
}

class InitializeCounterAction {}
class CancelCounterAction {}

class SetCounterAction {
  final int counter;
  SetCounterAction(this.counter);
}

ThunkAction<AppState> IncrementCountThunkAction = (Store<AppState> store) async {
  DocumentReference counter = Firestore.instance.document('counts/test');

  await counter
    .updateData({
      'count': FieldValue.increment(1),
    });
}; 