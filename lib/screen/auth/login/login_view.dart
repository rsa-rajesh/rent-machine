import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/app_managers/assets_managers.dart';
import '../../../core/enums/validation_type.dart';
import '../../widgets/buttons.dart';
import '../../widgets/input_fields.dart';
import 'login_logic.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginLogic>(builder: (logic) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      AssetManager.appLogo,
                      width: 70,
                      height: 70,
                    ),
                  ),
                  Gap(12),
                  Text(
                    "Rent Mechine",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "version 1.0.0",
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                  Gap(64),
                  Text(
                    "LOGIN",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Gap(16),
                  CostumeFormField(
                    validationType: ValidationType.email,
                    controller: logic.userNameController,
                    hintText: "Enter your Username",
                    onChanged: (){
                      setState(() {

                      });
                    },
                    labelText: "Email",
                  ),
                  Gap(16),
                  CostumeFormField(
                    validationType: ValidationType.password,
                    controller: logic.passwordController,
                    hintText: "Enter your Password",
                    labelText: "Password",
                    onChanged: (){
                      setState(() {

                      });
                    },
                  ),
                  Gap(64),
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
        ),
      );

    });
  }
}
