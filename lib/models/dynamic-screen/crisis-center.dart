class CrisisCenterResModel {
  List<CrisisCenter> data;
  String message;

  CrisisCenterResModel({this.data, this.message});

  CrisisCenterResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CrisisCenter>[];
      json['data'].forEach((v) {
        data.add(new CrisisCenter.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class CrisisCenter {
  int id;
  String name;
  int phoneNumber;
  String profilePic;

  CrisisCenter({this.id, this.name, this.phoneNumber, this.profilePic});

  CrisisCenter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}
