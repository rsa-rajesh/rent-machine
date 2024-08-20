import 'package:get/get.dart';

import 'add_user_logic.dart';

class AddUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddUserLogic());
  }
}
