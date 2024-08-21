import 'package:get/get.dart';

import 'dispatch_machine_logic.dart';

class DispatchMachineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DispatchMachineLogic());
  }
}
