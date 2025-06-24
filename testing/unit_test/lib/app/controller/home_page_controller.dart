import 'package:get/get.dart';

class HomePageController extends GetxController {
  final String title = 'Flutter Counter App';
  final String msg = 'You have pushed the button this many times:';
  final RxInt counter = 0.obs;

  increment() => counter.value++;
  decrement() => counter.value--;
}
