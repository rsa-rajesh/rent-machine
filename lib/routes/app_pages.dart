import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:rent_mechine/screen/add_machine/add_machine_binding.dart';
import 'package:rent_mechine/screen/add_machine/add_machine_view.dart';
import 'package:rent_mechine/screen/auth/add_user/add_user_binding.dart';
import 'package:rent_mechine/screen/auth/add_user/add_user_view.dart';
import 'package:rent_mechine/screen/auth/login/login_binding.dart';
import 'package:rent_mechine/screen/auth/login/login_view.dart';
import 'package:rent_mechine/screen/view_machine/view_machine_view.dart';
import 'package:rent_mechine/screen/welcome/welcome_binding.dart';
import 'package:rent_mechine/screen/welcome/welcome_view.dart';
import '../screen/view_machine/view_machine_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.homeScreen,
        page: () => const LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.addUserScreen,
        page: () => const AddUserPage(),
        binding: AddUserBinding()),
    GetPage(
        name: AppRoutes.welcomeScreen,
        page: () => const WelcomePage(),
        binding: WelcomeBinding()),
    GetPage(
        name: AppRoutes.addMachineScreen,
        page: () => const AddMachinePage(),
        binding: AddMachineBinding()),
    GetPage(
        name: AppRoutes.viewMachineScreen,
        page: () => const ViewMachinePage(),
        binding: ViewMachineBinding()),
  ];
}
