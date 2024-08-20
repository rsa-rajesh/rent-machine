import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rent_mechine/core/app_managers/assets_managers.dart';

import 'welcome_logic.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

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
                    "Welcome :Username",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Gap(32),
                Card(
                  color: Colors.green[100],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Image.asset(
                          AssetManager.appLogo,
                          width: 60,
                        ),
                        Gap(22),
                        Text(
                          "ADD MECHINE",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(12),
                Card(
                  color: Colors.blue[100],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Image.asset(
                          AssetManager.appLogo,
                          width: 60,
                        ),
                        Gap(22),
                        Text(
                          "VIEW MECHINE",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
