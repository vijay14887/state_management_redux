import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';

class DisplayCount extends StatefulWidget {
  // final Store<int> store;
  DisplayCount({
    Key? key,
    // required this.store,
  }) : super(key: key);

  @override
  State<DisplayCount> createState() => _DisplayCountState();
}

class _DisplayCountState extends State<DisplayCount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Display Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StoreConnector<int, String>(
              converter: (store) => store.state.toString(),
              builder: (context, count) {
                return Text(
                  'Current count State: $count',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
