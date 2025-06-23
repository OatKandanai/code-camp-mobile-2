import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_learning/bindings/home_binding.dart';
import 'package:getx_learning/home.dart';
import 'package:getx_learning/login.dart';
import 'package:getx_learning/second_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Login()),
        GetPage(name: '/home', page: () => Home(), binding: HomeBinding()),
        GetPage(name: '/second', page: () => SecondScreen()),
      ],
    ),
  );
}
