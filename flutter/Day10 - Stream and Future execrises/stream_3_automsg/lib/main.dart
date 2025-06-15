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
      home: const MyHomePage(title: 'Display Message Every 2 Sec'),
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
  late StreamController<String> controller;
  List<String> msg = [];

  @override
  void initState() {
    super.initState();
    controller = StreamController<String>();
  }

  Stream<String> showMsg() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 2));
      yield 'test';
    }
  }

  void startShowMsg() {
    showMsg().listen((value) {
      setState(() {
        msg.add(value);
      });
      controller.add(value);
    });
  }

  @override
  void dispose() {
    controller.close();
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
            StreamBuilder<String>(
              stream: controller.stream,
              builder: (context, snapshot) {
                return Text(msg.toString());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startShowMsg();
        },
        child: const Icon(Icons.start),
      ),
    );
  }
}
