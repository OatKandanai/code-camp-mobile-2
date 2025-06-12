import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'DAY3_HW', home: const Question5());
  }
}

class Question1 extends StatelessWidget {
  const Question1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: Container(color: Colors.yellow)),
          Expanded(
            child: Column(
              children: [
                Expanded(flex: 2, child: Container(color: Colors.deepOrange)),
                Expanded(child: Container(color: Colors.green)),
                Expanded(child: Container(color: Colors.purpleAccent)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Question2 extends StatelessWidget {
  const Question2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: Container(color: Colors.yellow)),
          Expanded(
            child: Column(
              children: [
                Expanded(child: Container(color: Colors.deepOrange)),
                Expanded(child: Container(color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Question3 extends StatelessWidget {
  const Question3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Container(color: Colors.yellow)),
          Expanded(
            child: Row(
              children: [
                Expanded(child: Container(color: Colors.deepOrange)),
                Expanded(child: Container(color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Question4 extends StatelessWidget {
  const Question4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: Container(color: Colors.yellowAccent)),
          Expanded(child: Container(color: Colors.deepOrange)),
        ],
      ),
    );
  }
}

class Question5 extends StatelessWidget {
  const Question5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Container(color: Colors.yellowAccent)),
          Expanded(child: Container(color: Colors.deepOrange)),
        ],
      ),
    );
  }
}
