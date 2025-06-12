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
      title: 'Time Stream',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Time Stream'),
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
  @override
  void initState() {
    super.initState();
  }

  Stream<DateTime> timeCount() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TimeStream'), centerTitle: true),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            timeStream('Hours', (dt) => dt.hour),
            timeStream('Minutes', (dt) => dt.minute),
            timeStream('Second', (dt) => dt.second),
          ],
        ),
      ),
    );
  }

  Column timeStream(String label, int Function(DateTime) extract) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 221, 221, 221),
            border: Border.all(width: 1,color: Colors.grey.shade500),
            borderRadius: BorderRadius.circular(15),
          ),
          child: StreamBuilder<DateTime>(
            stream: timeCount(),
            builder: (context, asyncSnapshot) {
              final value = extract(asyncSnapshot.data!);
              return Text(
                '$value',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
