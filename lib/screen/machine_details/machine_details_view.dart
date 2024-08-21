import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../view_machine/view_machine_logic.dart';
import '../widgets/arrow_clip.dart';
import '../widgets/buttons.dart';
class MachineDetailsPage extends StatefulWidget {
  const MachineDetailsPage({super.key});

  @override
  State<MachineDetailsPage> createState() => _MachineDetailsPageState();
}

class _MachineDetailsPageState extends State<MachineDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewMachineLogic>(builder: (logic) {
      return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: const Text("Machine Details"),
            centerTitle: true,
            actions: [
              Visibility(
                visible: logic.selectedMachine?.machineData?.status=="available",
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 80,
                    child: CostumeButtons.common(
                      labelText: 'Rent',
                      onPressed: () {
                        logic.rentMachine(logic.selectedMachine?.key);
                      },
                      isEnabled: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Image.network(
                                fit: BoxFit.fill,
                                width: 130,
                                height: 130,
                                logic.selectedMachine!.machineData!.machinePhoto.toString())),
                      ),
                      const Gap(12),
                       Text(
                        logic.selectedMachine!.machineData!.machineType.toString(),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text("Serial No: ${logic.selectedMachine!.machineData!.serialNo.toString()}"),
                    ],
                  ),
                ),
              ),
              const Gap(22),
              ClipPath(
                clipper: ArrowClipReversed(8),
                child: Container(
                  color: Colors.red,
                  child: const Padding(
                    padding:
                        EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 20),
                    child: Text(
                      "RENTAL DETAILS",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.only(left: 12, right: 12,top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Status: ${logic.selectedMachine?.machineData?.status}"),
                    Gap(6),
                    Text("Started at: ${logic.selectedMachine?.machineData?.startDate??"-"}"),
                    Gap(6),
                    Text("End on: ${logic.selectedMachine?.machineData?.endDate??"-"}"),
                  ],
                ),
              ),
              const Gap(22),
              ClipPath(
                clipper: ArrowClipReversed(8),
                child: Container(
                  color: Colors.red,
                  child: const Padding(
                    padding:
                    EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 20),
                    child: Text(
                      "USER DETAILS",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.only(left: 12, right: 12,top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${logic.selectedMachine?.machineData?.renterName??"-"}"),
                    Gap(6),
                    Text("Contact: ${logic.selectedMachine?.machineData?.renterContact??"-"}"),
                    Gap(6),
                    Text("Site: ${logic.selectedMachine?.machineData?.rentSite??"-"}"),

                  ],
                ),
              ),

              const Gap(22),
              ClipPath(
                clipper: ArrowClipReversed(8),
                child: Container(
                  color: Colors.red,
                  child: const Padding(
                    padding:
                    EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 20),
                    child: Text(
                      "DISPATCHED BY",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.only(left: 12, right: 12,top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${logic.selectedMachine?.machineData?.dispatcherName??"-"}"),
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
