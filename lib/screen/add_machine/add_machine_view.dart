import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/app_managers/assets_managers.dart';
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
          title: logic.isUpdate?const Text("Update Machine"):const Text("Add Machine"),
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
              const Gap(12),
              CostumeFormField(
                validationType: ValidationType.common,
                controller: logic.typeOfMachineController,
                hintText: "Type of Machine",
                onChanged: () {
                  setState(() {});
                },
                labelText: "Type of Machine",
              ),
              const Gap(12),
              const Text("Add Photo"),
              const Gap(6),
              GestureDetector(
                onTap: (){
                  selectImage(logic);
                  // logic.pickImage(ImageSource.camera);--
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 100,
                    width: 100,
                    child: Center(
                      child: logic.pickedFile == null
                          ? logic.isUpdate?Image.network(logic.imageUrl):const Icon(Icons.add)
                          : Image.file(logic.pickedFile!),
                    ),
                  ),
                ),
              ),
              const Gap(62),
              CostumeButtons.common(
                labelText: logic.isUpdate?"Update Machine":'Add Machine',
                onPressed: () {
                  logic.isUpdate?logic.updateMachineDate():
                  logic.addMachine();
                },
                isEnabled: logic.validateFields(),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future selectImage(AddMachineLogic logic) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  children: [
                    Spacer(),

                    Text(
                      'Select Image From !',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            logic.pickImage(ImageSource.gallery);
                            Get.back();

                          },
                          child: Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      AssetManager.galleryIcon,
                                      height: 60,
                                      width: 100,
                                    ),
                                    Text('Gallery'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            logic.pickImage(ImageSource.camera);
                            Get.back();
                          },
                          child: Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      AssetManager.cameraIcon,
                                      height: 60,
                                      width: 100,
                                    ),
                                    Text('Camera'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    Spacer(),

                  ],
                ),
              ),
            ),
          );
        });
  }

}
