import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rent_mechine/core/app_managers/assets_managers.dart';
import 'package:rent_mechine/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'welcome_logic.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeLogic>(builder: (logic) {
      return Scaffold(
        body: Stack(
          children: [
            SizedBox(
                height: double.infinity,
                child: Image.asset(
                  AssetManager.bg2,
                  height: double.infinity,
                  fit: BoxFit.fitHeight,
                )),
            Container(
              color: Colors.black.withAlpha(150),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 22, left: 22, right: 22),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Welcome : ${logic.userName}",
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const Gap(32),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.viewMachineScreen);
                      },
                      child: Card(
                        color: Colors.blue[100]?.withAlpha(160),
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
                          const Gap(12),
                          GestureDetector(
                            onTap: () {
                              logic.addMachine();
                            },
                            child: Card(
                              color: Colors.green[100]?.withAlpha(160),
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
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: Column(
                              children: [
                                const Gap(12),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.reportScreen);
                                  },
                                  child: Card(
                                    color: Colors.blue[100]?.withAlpha(160),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            AssetManager.reportIcon,
                                            width: 60,
                                          ),
                                          const Gap(22),
                                          const Text(
                                            "VIEW REPORTS",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: true,
                            child: Column(
                              children: [
                                const Gap(12),
                                GestureDetector(
                                  onTap: () {
                                   logic.downloadReport();
                                  },
                                  child: Card(
                                    color: Colors.blue[100]?.withAlpha(160),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            AssetManager.reportIcon,
                                            width: 60,
                                          ),
                                          const Gap(22),
                                          const Text(
                                            "DOWNLOAD REPORTS",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Gap(12),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.listUserScreen);
                            },
                            child: Card(
                              color: Colors.blue[100]?.withAlpha(160),
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
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Gap(12),
                    GestureDetector(
                      onTap: () {
                        logic.logout();
                      },
                      child: Card(
                        color: Colors.blue[100]?.withAlpha(160),
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
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(logic.showBranding()?"Version 1.0.2 | Powered by   ":"Version 1.0.2",style: const TextStyle(color: Colors.grey),),
                            logic.showBranding()?GestureDetector(
                                onTap: _launchURL,
                                child: Text(
                                  "Adira Tech",
                                  style: TextStyle(
                                    color: Colors.red,
                                    // decoration:
                                    //     TextDecoration.underline,
                                  ),
                                )):const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
  _launchURL() async {
    final Uri url = Uri.parse("https://www.adiratech.com/");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
