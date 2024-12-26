import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../app_managers/assets_managers.dart';
import '../app_managers/color_manager.dart';

class RepairDialog extends StatelessWidget {
  final Function(String name,String address,String contact)? onButton1Clicked;

  const RepairDialog({
    super.key,
    this.onButton1Clicked,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController repairCompanyNameController = TextEditingController();
    TextEditingController repairCompanyAddressController =
        TextEditingController();
    TextEditingController repairCompanyContactController =
        TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Repair Info.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.red),
                      ),
                      Gap(12),
                      TextField(
                        controller: repairCompanyNameController,
                        maxLines: 1, //or null
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.textDark,
                                ),
                                borderRadius: BorderRadius.circular(6)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(6)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.errorOpacity50,
                                ),
                                borderRadius: BorderRadius.circular(6)),
                            labelText: 'Company Name',
                            hintText: "Enter Company Name"),
                      ),
                      const Gap(6),
                      TextField(
                        controller: repairCompanyAddressController,
                        maxLines: 1, //or null
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.textDark,
                                ),
                                borderRadius: BorderRadius.circular(6)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(6)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.errorOpacity50,
                                ),
                                borderRadius: BorderRadius.circular(6)),
                            labelText: 'Company Address',
                            hintText: "Enter Company Address"),
                      ),
                      const Gap(6),
                      TextField(
                        keyboardType: TextInputType.phone,
                        controller: repairCompanyContactController,
                        maxLines: 1, //or null
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.textDark,
                                ),
                                borderRadius: BorderRadius.circular(6)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(6)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.errorOpacity50,
                                ),
                                borderRadius: BorderRadius.circular(6)),
                            labelText: 'Company Contact',
                            hintText: "Enter Company Contact"),
                      ),
                      const Gap(22),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                onButton1Clicked!(repairCompanyNameController.text.toString(),repairCompanyAddressController.text.toString(),repairCompanyContactController.text.toString());
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  backgroundColor: Colors.black),
                              child: const Padding(
                                padding: EdgeInsets.all(14),
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
