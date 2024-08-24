import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_mechine/routes/app_routes.dart';

class WelcomeLogic extends GetxController {

  final storage = GetStorage();
  String userName="";

  @override
  void onInit() {
    userName = storage.read("name");
    super.onInit();
  }

  void logout() {
    storage.erase();
    Get.offAndToNamed(AppRoutes.loginScreen);
  }

  isAdmin() {
    if(storage.read("role").toString().toLowerCase()=="admin"){
      return true;
    }
    else{
      return false;
    }
  }

  void addMachine() {
    storage.write("is_update_machine", false);
    storage.write("update_machine_id", "");
    storage.write("update_machine", "");

    Get.toNamed(AppRoutes.addMachineScreen);

  }

}
