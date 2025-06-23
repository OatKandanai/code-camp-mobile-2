import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_learning/controller.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final Controller count = Get.find();
  final msg = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(msg),
              const SizedBox(height: 20),
              Text('Counter : ${count.counter}'),
              const SizedBox(height: 20),
              IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.arrow_back_ios_new_sharp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
