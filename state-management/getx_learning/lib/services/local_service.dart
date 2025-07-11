import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalKeys {
  /// name key for TextField home.dart
  static String name = 'name';
}

class LocalService extends GetxService {
  final GetStorage box = GetStorage();

  String readName() {
    return box.read(LocalKeys.name) ?? '';
  }

  Future<void> setName(String value) async {
    await box.write(LocalKeys.name, value);
  }
}
