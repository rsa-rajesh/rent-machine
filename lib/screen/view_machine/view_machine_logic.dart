import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewMachineLogic extends GetxController {
  List<bool> isSelected = [
    true,
    false,
    false,
  ];

  getStatusFillColor(String orderStatus) {
    if (orderStatus.toLowerCase() == "confirmed") {
      return Colors.green[50];
    } else if (orderStatus.toLowerCase() == "cancelled") {
      return Colors.red[50];
    }

    return Colors.blue[50];
  }

  getStatusColor(String orderStatus) {
    if (orderStatus.toLowerCase() == "confirmed") {
      // return Colors.blue[50];
      return Colors.green[900];
    } else if (orderStatus.toLowerCase() == "cancelled") {
      return Colors.red[900];
    }

    return Colors.blue[900];
  }

  getSelectedFillColor() {
    if (isSelected[0]) {
      return Colors.blue[50];
    }
    if (isSelected[1]) {
      return Colors.green[50];
    }
    if (isSelected[2]) {
      return Colors.red[50];
    }
  }

  getSelectedColor() {
    if (isSelected[0]) {
      return Colors.blue[900];
    }
    if (isSelected[1]) {
      return Colors.green[900];
    }
    if (isSelected[2]) {
      return Colors.red[900];
    }
  }
}
