import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_common/get_reset.dart';

import '../app_managers/assets_managers.dart';
import '../app_managers/color_manager.dart';

class CostumeRemarksDialog extends StatelessWidget {
  final bool cancelable;
  final Function(String)? onButton1Clicked;

  const CostumeRemarksDialog({
    super.key,
    this.cancelable = false,
    this.onButton1Clicked,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController remarksController = TextEditingController();

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
                if (cancelable) {
                  Navigator.pop(context);
                }
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Remarks",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const Gap(12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              TextField(
                                controller: remarksController,
                                maxLines: 4, //or null
                                decoration: const InputDecoration.collapsed(
                                    hintText: "Enter your remarks here"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: ElevatedButton(
                                      onPressed: (onButton1Clicked) != null
                                          ? () {
                                              Navigator.pop(context);
                                              String remarks = remarksController.text.isNotEmpty?remarksController.text:"-";
                                              onButton1Clicked!(remarks);
                                            }
                                          : () {
                                              Navigator.pop(context);
                                            },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          backgroundColor: Colors.green),
                                      child: const Padding(
                                        padding: EdgeInsets.all(14),
                                        child: Text(
                                          "Submit",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      )),
                                ),
                              ),
                            ]),
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
