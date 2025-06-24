// import 'package:flutter_getx/app/controller/home_controller/home_page_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:unit_test/app/controller/home_page_controller.dart';

void main() {
  late HomePageController homePageController;

  setUp(() {
    Get.testMode = true;
    homePageController = HomePageController();
  });

  group('HomePageController Test', () {
    test('Initial values are correct', () {
      //ทดสอบแบบเปลี่ยนเทียบค่า
      expect(homePageController.title, 'Flutter Demo Home Page');
      expect(homePageController.msg, 'You have pushed the button this many times:');
      expect(homePageController.counter.value, 0);
    });

    test('counterAdd increments counter', () {
      homePageController.counter.value = 0; // ตั้งค่าเริ่มต้นเป็น 0

      homePageController.increment(); // เรียกใช้

      expect(homePageController.counter.value, 1); // ตรวจสอบผล
    });

    test('counterRemove decrements counter', () {
      homePageController.counter.value = 1; // ตั้งค่าเริ่มต้นเป็น 1

      homePageController.decrement(); // เรียกใช้

      expect(homePageController.counter.value, 0); // ตรวจสอบผล
    });
  });
}
