import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'report_logic.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReportLogic logic = Get.put(ReportLogic());

    return Container();
  }
}
