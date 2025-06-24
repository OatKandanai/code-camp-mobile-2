import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_learning/services/local_service.dart';

class Controller extends GetxController {
  final RxInt counter = 0.obs;
  late TextEditingController controller;
  final RxString name = ''.obs;
  final LocalService localService;

  Controller({required this.localService});

  @override
  void onInit() {
    super.onInit();
    controller = TextEditingController();
    setupData();
  }

  increment() => counter.value++;

  void setupData() {
    controller.text = localService.readName();
    name.value = controller.text.trim();
  }

  void submit() {
    name.value = controller.text.trim();
    localService.setName(name.value);
  }
}
