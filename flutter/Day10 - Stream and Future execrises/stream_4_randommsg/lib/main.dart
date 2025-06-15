import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

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
      home: const MyHomePage(title: 'Random Message Every 5 Sec'),
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
  List<String> msg = [
    'อากาศร้อน',
    'ฝนตก',
    'มีโปรโมชั่นใหม่!',
    'สวัสดีตอนเช้า',
    'อย่าลืมดื่มน้ำ',
    'สุขสันต์วันหยุด',
    'พบกันใหม่พรุ่งนี้',
    'เชิญร่วมกิจกรรมพิเศษ',
    'ข่าวดีมาแล้ว!',
    'ลดราคาสินค้า 50%',
  ];
  bool active = false;
  Timer? timer;

  Stream<String> randomMsg() async* {
    while (active) {
      yield msg[Random().nextInt(msg.length)];
      await Future.delayed(Duration(seconds: 5));
    }
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
              stream: randomMsg(),
              initialData: 'สุ่มข้อความ',
              builder: (context, snapshot) {
                return Text(snapshot.data.toString());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            active = !active;
          });
        },
        child: const Icon(Icons.restart_alt),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
