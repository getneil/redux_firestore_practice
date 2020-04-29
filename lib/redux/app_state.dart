import 'package:flutter/foundation.dart';

class AppState {
  final int counter;

  const AppState({
    @required this.counter = 0,
  });

  AppState copyWith({int counter}) => new AppState(counter: counter ?? this.counter);
}