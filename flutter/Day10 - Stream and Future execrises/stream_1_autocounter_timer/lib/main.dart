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
  late final StreamController<int> controller;
  Timer? timer;
  late int count;

  @override
  void initState() {
    super.initState();
    controller = StreamController<int>();
    count = 1;
  }

  void startCounting() {
    timer?.cancel(); // avoid mutiple click
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      controller.add(count);
      count++;
    });
  }

  void stopCounting() {
    timer?.cancel();
    controller.add(count); // add the latest count
  }

  @override
  void dispose() {
    timer?.cancel();
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
        child: StreamBuilder<int>(
          stream: controller.stream,
          initialData: 1,
          builder: (context, snapshot) {
            return Text('${snapshot.data}', style: TextStyle(fontSize: 25));
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: startCounting,
              child: const Text('Start'),
            ),
            ElevatedButton(onPressed: stopCounting, child: const Text('Stop')),
          ],
        ),
      ),
    );
  }
}
