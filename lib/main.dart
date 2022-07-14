import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'display.dart';
// import 'common.dart';

enum Actions { increment, decrement }

int counterReducer(int state, dynamic action) {
  if (action == Actions.increment) {
    return state + 1;
  } else if (action == Actions.decrement) {
    return state - 1;
  }
  return state;
}

loggingMiddleware(Store<int> store, action, NextDispatcher next) {
  print('${DateTime.now()}: $action');
  next(action);
}

void main() {
  final store = Store<int>(
    counterReducer,
    initialState: 0,
    middleware: [loggingMiddleware],
  );
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<int> store;
  const MyApp({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<int>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(title: 'Flutter Redux Demo'),
          // '/display': (context) => DisplayCount(store: store),
          '/display': (context) => DisplayCount(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StoreConnector<int, VoidCallback>(builder: (context, callback) {
              return ElevatedButton(
                onPressed: callback,
                child: const Text("+"),
              );
            }, converter: (store) {
              return () => store.dispatch(Actions.increment);
            }),
            StoreConnector<int, VoidCallback>(builder: (context, callback) {
              return ElevatedButton(
                onPressed: callback,
                child: const Text("-"),
              );
            }, converter: (store) {
              return () => store.dispatch(Actions.decrement);
            }),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/display');
              },
              child: const Text("DISPLAY"),
            )
          ],
        ),
      ),
    );
  }
}
