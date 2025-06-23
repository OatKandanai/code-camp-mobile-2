import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_learning/services/local_service.dart';

class Controller extends GetxController {
  final LocalService localService;

  Controller({required this.localService});

  RxInt counter = 0.obs;
  final RxString name = ''.obs;
  late TextEditingController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TextEditingController();
    setupData();
  }

  increment() => counter++;

  void setupData() {
    controller.text = localService.readName();
    name.value = controller.text.trim();
  }

  void submit() {
    name.value = controller.text.trim();
    localService.setName(name.value);
  }
}
