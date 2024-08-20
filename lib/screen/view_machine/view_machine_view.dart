import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../core/app_managers/assets_managers.dart';
import 'view_machine_logic.dart';

class ViewMachinePage extends StatefulWidget {
  const ViewMachinePage({Key? key}) : super(key: key);

  @override
  State<ViewMachinePage> createState() => _ViewMachinePageState();
}

class _ViewMachinePageState extends State<ViewMachinePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewMachineLogic>(builder: (logic) {
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            title: Text("View Machine"),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Gap(12),
              ToggleButtons(
                  fillColor: logic.getSelectedFillColor(),
                  selectedColor: logic.getSelectedColor(),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  onPressed: (int index) {
                    logic.isSelected = [false, false, false];
                    logic.isSelected[index] = true;
                    setState(() {});
                  },
                  isSelected: logic.isSelected,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                      child: Row(
                        children: [
                          Icon(Icons.pending_outlined),
                          Gap(8),
                          Text(
                            "Available",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_outline),
                          Gap(8),
                          Text(
                            "On-Site",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.cancel_outlined),
                          Gap(8),
                          Text(
                            "Ranted",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ]),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 4.0),
                      child: GestureDetector(
                        onTap: () {
                          // Get.toNamed(AppRoutes.noticeDetailsScreen);
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    AssetManager.appLogo,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        const SizedBox(
                                          width: 200,
                                          child: Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            "Type of Machine",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const Text(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          "serial number",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Row(
                                          children: [
                                            Spacer(),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.green[100],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 4),
                                                child: Text(
                                                  "status",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.green[900]),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                ),
              ),
            ],
          ));
    });
  }
}
