class Users {
  String? key;
  UserData? userData;
  Users({this.key, this.userData});
}

class UserData {
  String? contact;
  String? fullName;
  String? password;
  String? position;

  UserData({this.contact, this.fullName, this.password, this.position});

  UserData.fromJson(Map<String, dynamic> json) {
    contact = json['contact'];
    fullName = json['fullName'];
    position = json['position'];
    password = json['password'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contact'] = contact;
    data['fullName'] = fullName;
    data['position'] = position;
    data['password'] = password;
    return data;
  }
}
