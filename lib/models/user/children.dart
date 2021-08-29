class ChildrenResModel {
  List<Child> data;
  String message;

  ChildrenResModel({this.data, this.message});

  ChildrenResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Child>[];
      json['data'].forEach((v) {
        data.add(new Child.fromJson(v));
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

class ChildResModel {
  Child data;
  String message;

  ChildResModel({this.data, this.message});

  ChildResModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Child.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Child {
  int id;
  String fullName;
  String birthOfDate;
  String birthPlace;
  String gender;
  dynamic dedication;
  dynamic profilePic;
  dynamic qrCode;
  String childBirthCertificationFile;

  Child({
    this.id,
    this.fullName,
    this.birthOfDate,
    this.birthPlace,
    this.gender,
    this.dedication,
    this.profilePic,
    this.qrCode,
    this.childBirthCertificationFile,
  });

  Child.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    birthOfDate = json['birth_of_date'];
    birthPlace = json['birth_place'];
    gender = json['gender'];
    dedication = json['dedication'];
    profilePic = json['profile_pic'] == null ? '' : json['profile_pic'];
    qrCode = json['qr_code'];
    childBirthCertificationFile = json['child_birth_certification_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['birth_of_date'] = this.birthOfDate;
    data['birth_place'] = this.birthPlace;
    data['gender'] = this.gender;
    data['dedication'] = this.dedication;
    data['profile_pic'] = this.profilePic;
    data['qr_code'] = this.qrCode;
    data['child_birth_certification_file'] = this.childBirthCertificationFile;
    return data;
  }
}
