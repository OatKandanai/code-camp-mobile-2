import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 1;
  StreamController<int> controller = StreamController<int>();
  StreamSubscription<int>? subscription;

  Stream<int> countStream() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      count++;
      yield count;
    }
  }

  void startCount() {
    subscription?.cancel();
    subscription = countStream().listen((value) {
      controller.add(value);
    });
  }

  void stopCount() {
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: controller.stream,
              initialData: count,
              builder: (context, snapshot) {
                return Text(snapshot.data.toString());
              },
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: startCount,
                  child: const Text('start'),
                ),
                ElevatedButton(onPressed: stopCount, child: const Text('stop')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
