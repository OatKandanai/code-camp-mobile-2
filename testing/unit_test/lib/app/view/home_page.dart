import 'package:flutter/material.dart';
import 'package:unit_test/app/controller/home_page_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomePageController homeController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(homeController.title), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(homeController.msg),
            Obx(
              () => Text(
                '${homeController.counter.value}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: homeController.increment,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: homeController.decrement,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
