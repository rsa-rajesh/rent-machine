class Machine {
  String? key;
  MachineData? machineData;

  Machine({this.key, this.machineData});
}

class MachineData {
  String? serialNo;
  String? status;
  String? machineType;
  String? machinePhoto;

  //rental details
  String? startDate;
  String? endDate;

  //user details
  String? renterName;
  String? renterContact;
  String? rentSite;

  //dispatcher details
  String? dispatcherName;

  MachineData(
      {this.serialNo,
      this.status,
      this.machinePhoto,
      this.machineType,
      this.startDate,
      this.endDate,
      this.renterName,
      this.renterContact,
      this.rentSite,
      this.dispatcherName});

  MachineData.fromJson(Map<String, dynamic> json) {
    serialNo = json['serialNo'];
    status = json['status'];
    machinePhoto = json['machinePhoto'];
    machineType = json['machineType'];

    startDate = json['startDate'];
    endDate = json['endDate'];
    renterName = json['renterName'];
    rentSite = json['rentSite'];
    dispatcherName = json['dispatcherName'];
    renterContact = json['renterContact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serialNo'] = serialNo;
    data['status'] = status;
    data['machinePhoto'] = machinePhoto;
    data['machineType'] = machineType;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['renterName'] = renterName;
    data['rentSite'] = rentSite;
    data['dispatcherName'] = dispatcherName;
    data['renterContact'] = renterContact;

    return data;
  }
}
