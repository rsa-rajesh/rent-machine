import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WelcomeLogic extends GetxController {

  final storage = GetStorage();
  String userName="";

  @override
  void onInit() {
    userName = storage.read("name");
    super.onInit();
  }

}
