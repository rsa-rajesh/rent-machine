import 'package:get/get.dart';

import 'view_machine_logic.dart';

class ViewMachineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewMachineLogic());
  }
}
