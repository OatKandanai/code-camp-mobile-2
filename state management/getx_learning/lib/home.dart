import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_learning/controller.dart';

class Home extends GetView<Controller> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text('Counter : ${controller.counter}')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.toNamed('/second', arguments: 'my msg'),
                child: const Text('To Second Screen'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.snackbar('title', 'message'),
                child: const Text('Show Snack Bar'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.defaultDialog(
                  title: 'title',
                  content: const Text('dialog content'),
                ),
                child: const Text('Show Dialog'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 140,
                    child: TextField(
                      controller: controller.controller,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: controller.submit,
                    child: const Text('submit'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(() => Text('Name : ${controller.name.value}')),
            ],
          ),
        ),
      ),
    );
  }
}
