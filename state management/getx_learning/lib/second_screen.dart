import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_learning/controller/controller.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final Controller controller = Get.find();
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
              Text('Counter : ${controller.counter.value}'),
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
