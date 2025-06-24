import 'package:get/get.dart';
import 'package:getx_learning/controller/controller.dart';
import 'package:getx_learning/services/local_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Controller(localService: LocalService()));
  }
}
