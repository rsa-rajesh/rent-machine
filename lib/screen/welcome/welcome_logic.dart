import 'dart:io';
import 'package:excel/excel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rent_mechine/routes/app_routes.dart';

import '../../core/widgets/loading_dialog.dart';
import '../../models/machine_list_model.dart';
import '../../models/machine_logs_list_model.dart';

class WelcomeLogic extends GetxController {
  final storage = GetStorage();
  String userName = "";
  List<Machine> machines = [];
  List<MachineLogs> machinesLogs = [];
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  @override
  void onInit() {
    userName = storage.read("name");
    super.onInit();
  }

  void logout() {
    storage.erase();
    Get.offAndToNamed(AppRoutes.loginScreen);
  }

  isAdmin() {
    if (storage.read("role").toString().toLowerCase() == "admin") {
      return true;
    } else {
      return false;
    }
  }

  void addMachine() {
    storage.write("is_update_machine", false);
    storage.write("update_machine_id", "");
    storage.write("update_machine", "");

    Get.toNamed(AppRoutes.addMachineScreen);
  }

  Future<void> downloadReport() async {
    // bool isError1 = false;
    // bool isError2 = false;

    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        context = context;
        return const Loading(
          'Creating Report...',
          false,
        );
      },
    );

    await databaseReference.child("machine").get().then((value) {
      machines.clear();
      for (DataSnapshot snapshot in value.children) {
        MachineData machineData = MachineData.fromJson(
            Map<String, dynamic>.from(snapshot.value as Map));
        machines.add(Machine(key: snapshot.key, machineData: machineData));
      }
    });
    await databaseReference.child("machine_logs").get().then((value) {
      machinesLogs.clear();
      for (DataSnapshot snapshot in value.children) {
        MachineLogsData machineLogData = MachineLogsData.fromJson(
            Map<String, dynamic>.from(snapshot.value as Map));
        machinesLogs.add(
            MachineLogs(key: snapshot.key, machineLogsData: machineLogData));
      }
    });

    var excel = Excel.createExcel();

    if (machines.isNotEmpty) {
      CellStyle headingCellStyle = CellStyle(
          backgroundColorHex: ExcelColor.blue100,
          fontFamily: getFontFamily(FontFamily.Calibri),
          fontSize: 16,
          bold: true);

      CellStyle columnCellStyle = CellStyle(
          fontFamily: getFontFamily(FontFamily.Arial),
          fontSize: 12,
          bold: false);

      Sheet sheetObject = excel['Machine List'];
      sheetObject.setColumnAutoFit(0);
      sheetObject.setColumnAutoFit(1);
      sheetObject.setColumnAutoFit(2);
      sheetObject.setColumnAutoFit(3);
      sheetObject.setColumnAutoFit(4);
      sheetObject.setColumnAutoFit(5);
      sheetObject.setColumnAutoFit(6);
      sheetObject.setColumnAutoFit(7);
      sheetObject.setColumnAutoFit(8);

      var cell = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0));
      cell.value = TextCellValue("Machine Id");
      cell.cellStyle = headingCellStyle;

      var cell1 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0));
      cell1.value = TextCellValue("Machine Type");
      cell1.cellStyle = headingCellStyle;

      var cell2 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0));
      cell2.value = TextCellValue("Status");
      cell2.cellStyle = headingCellStyle;

      var cell3 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0));
      cell3.value = TextCellValue("Dispatcher Name");
      cell3.cellStyle = headingCellStyle;

      var cell4 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0));
      cell4.value = TextCellValue("Start Date");
      cell4.cellStyle = headingCellStyle;

      var cell5 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0));
      cell5.value = TextCellValue("End Date");
      cell5.cellStyle = headingCellStyle;

      var cell6 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0));
      cell6.value = TextCellValue("Ranter Name");
      cell6.cellStyle = headingCellStyle;

      var cell7 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0));
      cell7.value = TextCellValue("Rent Site");
      cell7.cellStyle = headingCellStyle;

      var cell8 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0));
      cell8.value = TextCellValue("Renter Contact");
      cell8.cellStyle = headingCellStyle;

      for (int i = 0; i < machines.length; i++) {
        var cell = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1));
        cell.value = TextCellValue(machines[i].key ?? "");
        cell.cellStyle = columnCellStyle;

        var cell1 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1));
        cell1.value = TextCellValue(machines[i].machineData?.machineType ?? "");
        cell1.cellStyle = columnCellStyle;

        var cell2 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1));
        cell2.value = TextCellValue(machines[i].machineData?.status ?? "");
        cell2.cellStyle = columnCellStyle;

        var cell3 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1));
        cell3.value =
            TextCellValue(machines[i].machineData?.dispatcherName ?? "");
        cell3.cellStyle = columnCellStyle;

        var cell4 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1));
        cell4.value = TextCellValue(machines[i].machineData?.startDate ?? "");
        cell4.cellStyle = columnCellStyle;

        var cell5 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1));
        cell5.value = TextCellValue(machines[i].machineData?.endDate ?? "");
        cell5.cellStyle = columnCellStyle;

        var cell6 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1));
        cell6.value = TextCellValue(machines[i].machineData?.renterName ?? "");
        cell6.cellStyle = columnCellStyle;

        var cell7 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1));
        cell7.value = TextCellValue(machines[i].machineData?.rentSite ?? "");
        cell7.cellStyle = columnCellStyle;

        var cell8 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 1));
        cell8.value =
            TextCellValue(machines[i].machineData?.renterContact ?? "");
        cell8.cellStyle = columnCellStyle;
      }
      excel.delete('Sheet1');
    }
    if (machinesLogs.isNotEmpty) {
      CellStyle headingCellStyle = CellStyle(
          backgroundColorHex: ExcelColor.blue100,
          fontFamily: getFontFamily(FontFamily.Calibri),
          fontSize: 16,
          bold: true);

      CellStyle columnCellStyle = CellStyle(
          fontFamily: getFontFamily(FontFamily.Arial),
          fontSize: 12,
          bold: false);

      Sheet sheetObject = excel['Machine Logs'];
      sheetObject.setColumnAutoFit(0);
      sheetObject.setColumnAutoFit(1);
      sheetObject.setColumnAutoFit(2);
      sheetObject.setColumnAutoFit(3);
      sheetObject.setColumnAutoFit(4);
      sheetObject.setColumnAutoFit(5);
      sheetObject.setColumnAutoFit(6);
      sheetObject.setColumnAutoFit(7);
      sheetObject.setColumnAutoFit(8);
      sheetObject.setColumnAutoFit(9);
      sheetObject.setColumnAutoFit(10);
      sheetObject.setColumnAutoFit(11);
      sheetObject.setColumnAutoFit(12);
      sheetObject.setColumnAutoFit(13);

      var cell = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0));
      cell.value = TextCellValue("Machine Id");
      cell.cellStyle = headingCellStyle;

      var cell1 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0));
      cell1.value = TextCellValue("Action");
      cell1.cellStyle = headingCellStyle;

      var cell2 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0));
      cell2.value = TextCellValue("Bank/Wallet");
      cell2.cellStyle = headingCellStyle;

      var cell3 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0));
      cell3.value = TextCellValue("Cheque/Mobile");
      cell3.cellStyle = headingCellStyle;

      var cell4 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0));
      cell4.value = TextCellValue("Date");
      cell4.cellStyle = headingCellStyle;

      var cell5 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0));
      cell5.value = TextCellValue("Dispatcher");
      cell5.cellStyle = headingCellStyle;

      var cell6 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0));
      cell6.value = TextCellValue("Start Date");
      cell6.cellStyle = headingCellStyle;

      var cell7 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0));
      cell7.value = TextCellValue("End Date");
      cell7.cellStyle = headingCellStyle;

      var cell8 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0));
      cell8.value = TextCellValue("Pay Type");
      cell8.cellStyle = headingCellStyle;

      var cell9 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0));
      cell9.value = TextCellValue("Renter Name");
      cell9.cellStyle = headingCellStyle;

      var cell10 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0));
      cell10.value = TextCellValue("Renter Contact");
      cell10.cellStyle = headingCellStyle;

      var cell11 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 0));
      cell11.value = TextCellValue("Rent Site");
      cell11.cellStyle = headingCellStyle;

      var cell12 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 0));
      cell12.value = TextCellValue("Status");
      cell12.cellStyle = headingCellStyle;

      var cell13 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: 0));
      cell13.value = TextCellValue("Remarks");
      cell13.cellStyle = headingCellStyle;



      for (int i = 0; i < machinesLogs.length; i++) {
        var cell = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1));
        cell.value = TextCellValue(machinesLogs[i].machineLogsData?.machine??"");
        cell.cellStyle = columnCellStyle;

        var cell1 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1));
        cell1.value = TextCellValue(machinesLogs[i].machineLogsData?.action??"");
        cell1.cellStyle = columnCellStyle;

        var cell2 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1));
        cell2.value = TextCellValue(machinesLogs[i].machineLogsData?.bankOrWalletName??"");
        cell2.cellStyle = columnCellStyle;

        var cell3 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1));
        cell3.value = TextCellValue(machinesLogs[i].machineLogsData?.chequeOrMobileNo??"");
        cell3.cellStyle = columnCellStyle;

        var cell4 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1));
        cell4.value = TextCellValue(machinesLogs[i].machineLogsData?.date??"");
        cell4.cellStyle = columnCellStyle;

        var cell5 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1));
        cell5.value = TextCellValue(machinesLogs[i].machineLogsData?.dispatcherName??"");
        cell5.cellStyle = columnCellStyle;

        var cell6 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1));
        cell6.value = TextCellValue(machinesLogs[i].machineLogsData?.startDate??"");
        cell6.cellStyle = columnCellStyle;

        var cell7 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1));
        cell7.value = TextCellValue(machinesLogs[i].machineLogsData?.endDate??"");
        cell7.cellStyle = columnCellStyle;

        var cell8 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 1));
        cell8.value = TextCellValue(machinesLogs[i].machineLogsData?.paymentType??"");
        cell8.cellStyle = columnCellStyle;

        var cell9 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i + 1));
        cell9.value = TextCellValue(machinesLogs[i].machineLogsData?.renterName??"");
        cell9.cellStyle = columnCellStyle;

        var cell10 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i + 1));
        cell10.value = TextCellValue(machinesLogs[i].machineLogsData?.renterContact??"");
        cell10.cellStyle = columnCellStyle;

        var cell11 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i + 1));
        cell11.value = TextCellValue(machinesLogs[i].machineLogsData?.rentSite??"");
        cell11.cellStyle = columnCellStyle;

        var cell12 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: i + 1));
        cell12.value = TextCellValue(machinesLogs[i].machineLogsData?.status??"");
        cell12.cellStyle = columnCellStyle;

        var cell13 = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: i + 1));
        cell13.value = TextCellValue(machinesLogs[i].machineLogsData?.remarks??"");
        cell13.cellStyle = columnCellStyle;
      }
      excel.delete('Sheet1');
    }

    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      var fileBytes = excel.save();
      // var directory = await getDownloadsDirectory();
      bool dirDownloadExists = true;
      var directory;
      if (Platform.isIOS) {
        directory = await getDownloadsDirectory();
      } else {
        directory = "/storage/emulated/0/Download/";

        dirDownloadExists = await Directory(directory).exists();
        if (dirDownloadExists) {
          directory = "/storage/emulated/0/Download/";
        } else {
          directory = "/storage/emulated/0/Downloads/";
        }
      }
String a = DateTime.now().millisecondsSinceEpoch.toString();
      File('$directory/Geo-$a.xlsx')
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);


      Fluttertoast.showToast(
          msg: "Success, File saved to downloads",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

    } catch (e) {
      // print(e);
      Fluttertoast.showToast(
          msg: "Error!! Can't save file",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    Get.back();
  }

  bool showBranding() {
    int month = DateTime.now().month;
    int year = DateTime.now().year;
    if(year<=2025 && month<7 ){
      return false;
    }
    return true;
  }
}
