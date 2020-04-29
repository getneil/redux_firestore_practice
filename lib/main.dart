import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:firedux/redux/app_state.dart';
import 'package:firedux/redux/actions.dart';
import 'package:firedux/redux/reducer.dart';
import 'package:firedux/redux/middleware.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(
    appStateReducer,
    initialState: AppState(counter: 0),
    middleware: [thunkMiddleware]..addAll(appStateMiddleware()),
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}


class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({ Key key, this.title}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return StoreBuilder(
      onInit: (store) => store.dispatch(InitializeCounterAction()),
      // onDispose: (store) => store.dispatch(CancelCounterDataEventsAction()),
      builder: (context, Store<AppState> store) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '${store.state.counter}',
                  style: Theme.of(context).textTheme.display1,
                ),
                FlatButton(
                  child: Text('Cancel Listener'),
                  onPressed: () {
                    store.dispatch(CancelCounterAction());
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              store.dispatch(IncrementCountThunkAction);
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}
