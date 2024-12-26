import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/app_managers/assets_managers.dart';
import '../../../core/enums/validation_type.dart';
import '../../widgets/buttons.dart';
import '../../widgets/input_fields.dart';
import 'login_logic.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginLogic>(builder: (logic) {
      return Scaffold(
        body: Stack(
          children: [
            SizedBox(
                height: double.infinity,
                child: Image.asset(
                  AssetManager.bg3,
                  height: double.infinity,
                  fit: BoxFit.fitHeight,
                )),
            Container(
              color: Colors.black.withAlpha(150),
            ),
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22.0, vertical: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        AssetManager.appLogo,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const Gap(12),
                    const Text(
                      "Rent Machine",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Text(
                      "version 1.0.0",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const Gap(64),
                    const Text(
                      "LOGIN",
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    const Gap(16),
                    CostumeFormField(
                      validationType: ValidationType.phone,
                      inputType: TextInputType.phone,
                      controller: logic.phoneController,
                      hintText: "Enter your Mobile Number",
                      onChanged: () {
                        setState(() {});
                      },
                      labelText: "Mobile Number",
                    ),
                    const Gap(16),
                    CostumeFormField(
                      validationType: ValidationType.password,
                      controller: logic.passwordController,
                      hintText: "Enter your Password",
                      labelText: "Password",
                      onChanged: () {
                        setState(() {});
                      },
                    ),
                    const Gap(64),
                    CostumeButtons.common(
                      labelText: 'Login',
                      onPressed: () {
                        logic.login();
                      },
                      isEnabled: logic.validateFields(),
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
}
