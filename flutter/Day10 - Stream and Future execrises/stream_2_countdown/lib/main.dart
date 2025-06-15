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
      home: const MyHomePage(title: 'Count Down 10 Sec'),
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
  late StreamController<int> controller;

  @override
  void initState() {
    super.initState();
    controller = StreamController<int>();
  }

  Stream<int> countDown() async* {
    for (int i = 10; i >= 0; i--) {
      yield i;
      await Future.delayed(Duration(seconds: 1));
    }
  }

  void startCountDown() {
    countDown().listen((value) {
      controller.add(value);
    });
  }

  @override
  void dispose() {
    super.dispose();
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
            Text('นับถอยหลัง 10 วิ', style: TextStyle(fontSize: 25)),
            StreamBuilder(
              stream: controller.stream,
              initialData: 10,
              builder: (context, snapshot) {
                final output = snapshot.data == 0 ? 'หมดเวลา!' : snapshot.data;
                return Text('$output', style: TextStyle(fontSize: 25));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startCountDown();
        },
        child: const Icon(Icons.restore),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
