class MachineLogs {
  String? key;
  MachineLogsData? machineLogsData;

  MachineLogs({this.key, this.machineLogsData});
}

class MachineLogsData {
  String? machine;
  String? startDate;
  String? endDate;
  String? renterName;
  String? renterContact;
  String? rentSite;
  String? dispatcherName;

  String? action;
  String? bankOrWalletName;
  String? chequeOrMobileNo;
  String? date;

  // rental details
  String? paymentType;

  //user details
  String? remarks;
  String? status;

  MachineLogsData(
      {this.machine,
      this.action,
      this.bankOrWalletName,
      this.chequeOrMobileNo,
      this.date,
      this.paymentType,
      this.remarks,
      this.status,
      this.startDate,
      this.endDate,
      this.renterName,
      this.renterContact,
      this.rentSite,
      this.dispatcherName});

  MachineLogsData.fromJson(Map<String, dynamic> json) {
    machine = json['machine'];
    action = json['action'];
    bankOrWalletName = json['bankOrWalletName'];
    chequeOrMobileNo = json['chequeOrMobileNo'];
    date = json['date'];
    paymentType = json['paymentType'];
    remarks = json['remarks'];
    status = json['status'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    renterName = json['renterName'];
    renterContact = json['renterContact'];
    rentSite = json['rentSite'];
    dispatcherName = json['dispatcherName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['machine'] = machine;
    data['status'] = status;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['renterName'] = renterName;
    data['rentSite'] = rentSite;
    data['dispatcherName'] = dispatcherName;
    data['renterContact'] = renterContact;
    data['action'] = action;
    data['bankOrWalletName'] = bankOrWalletName;
    data['chequeOrMobileNo'] = chequeOrMobileNo;
    data['date'] = date;
    data['paymentType'] = paymentType;
    data['remarks'] = remarks;

    return data;
  }
}
