import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rent_mechine/core/app_managers/assets_managers.dart';
import 'package:rent_mechine/routes/app_routes.dart';

import 'welcome_logic.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeLogic>(builder: (logic) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Welcome : ${logic.userName}",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),

                Gap(32),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoutes.viewMachineScreen);
                  },
                  child: Card(
                    color: Colors.blue[100],
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Image.asset(
                            AssetManager.appLogo,
                            width: 60,
                          ),
                          const Gap(22),
                          const Text(
                            "VIEW MACHINE",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: logic.isAdmin(),
                  child: Column(
                    children: [
                      Gap(12),
                      GestureDetector(
                        onTap: () {
                          logic.addMachine();
                        },
                        child: Card(
                          color: Colors.green[100],
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  AssetManager.appLogo,
                                  width: 60,
                                ),
                                const Gap(22),
                                const Text(
                                  "ADD MACHINE",
                                  style: TextStyle(
                                      fontSize: 25, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Gap(12),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.listUserScreen);
                        },
                        child: Card(
                          color: Colors.blue[100],
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  AssetManager.userLogo,
                                  width: 60,
                                ),
                                const Gap(22),
                                const Text(
                                  "USERS LIST",
                                  style: TextStyle(
                                      fontSize: 25, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(12),
                GestureDetector(
                  onTap: (){
                    logic.logout();
                  },
                  child: Card(
                    color: Colors.blue[100],
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Image.asset(
                            AssetManager.logoutLogo,
                            width: 60,
                          ),
                          const Gap(22),
                          const Text(
                            "LOG OUT",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    });
  }
}
