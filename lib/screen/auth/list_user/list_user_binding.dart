import 'package:get/get.dart';

import 'list_user_logic.dart';

class ListUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListUserLogic());
  }
}
