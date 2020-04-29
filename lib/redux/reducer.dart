import 'package:firedux/redux/app_state.dart';
import 'package:firedux/redux/actions.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';


AppState appStateReducer(AppState state, dynamic action) {
  return new AppState(
    counter: counterReducer(state.counter, action),
  );
}

final counterReducer = combineReducers<int>([
  TypedReducer<int, SetCounterAction>(setCounter),
]);

// int incrementCounterReducer(int oldCount, action) {
//   return oldCount+1;
// }

int setCounter(int oldCounter, SetCounterAction action) {
  return action.counter;
}

