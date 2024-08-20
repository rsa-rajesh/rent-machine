import 'package:get/get.dart';

import 'add_machine_logic.dart';

class AddMachineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddMachineLogic());
  }
}
