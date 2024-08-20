import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../core/enums/validation_type.dart';
import '../widgets/buttons.dart';
import '../widgets/input_fields.dart';
import 'add_machine_logic.dart';

class AddMachinePage extends StatefulWidget {
  const AddMachinePage({super.key});

  @override
  State<AddMachinePage> createState() => _AddMachinePageState();
}

class _AddMachinePageState extends State<AddMachinePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMachineLogic>(builder: (logic) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Add Machine"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CostumeFormField(
                validationType: ValidationType.common,
                controller: logic.serialNoController,
                hintText: "Serial No",
                onChanged: () {
                  setState(() {});
                },
                labelText: "Serial No",
              ),
              Gap(12),
              CostumeFormField(
                validationType: ValidationType.common,
                controller: logic.typeOfMachineController,
                hintText: "Type of Machine",
                onChanged: () {
                  setState(() {});
                },
                labelText: "Type of Machine",
              ),
              Gap(12),
              Text("Add Photo"),
              Gap(6),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 100,
                width: 100,
                child: Center(
                  child: logic.imageFile == null
                      ? Icon(Icons.add)
                      : Image.file(logic.imageFile!),
                ),
              ),
              Gap(62),
              CostumeButtons.common(
                labelText: 'Add Machine',
                onPressed: () {
                  // logic.createUser();
                },
                isEnabled: logic.validateFields(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
