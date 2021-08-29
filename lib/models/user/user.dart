class UserResModel {
  User data;
  String message;

  UserResModel({this.data, this.message});

  UserResModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new User.fromJson(json['data']) : null;
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

class User {
  int id;
  String fullName;
  String birthPlace;
  String birthOfDate;
  String gender;
  String occupation;
  Address address;
  int phoneNumber;
  String email;
  dynamic qRcode;
  dynamic memberId;
  bool isVerified;
  String profilePic;
  String tokenUser;
  String tokenOneSignal;
  String tokenFirebase;
  int deviceType;

  User(
      {this.id,
      this.fullName,
      this.birthPlace,
      this.birthOfDate,
      this.gender,
      this.occupation,
      this.address,
      this.phoneNumber,
      this.email,
      this.qRcode,
      this.memberId,
      this.isVerified,
      this.profilePic,
      this.tokenUser,
      this.tokenOneSignal,
      this.tokenFirebase,
      this.deviceType});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    birthPlace = json['birth_place'];
    birthOfDate = json['birth_of_date'];
    gender = json['gender'];
    occupation = json['occupation'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    phoneNumber = json['phone_number'];
    email = json['email'];
    qRcode = json['QRcode'];
    memberId = json['member_id'];
    isVerified = json['isVerified'] != null ? json['isVerified'] : false;
    profilePic = json['profile_pic'];
    tokenUser = json['token_user'];
    tokenOneSignal = json['token_oneSignal'];
    tokenFirebase = json['token_firebase'];
    deviceType = json['device_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['birth_place'] = this.birthPlace;
    data['birth_of_date'] = this.birthOfDate;
    data['gender'] = this.gender;
    data['occupation'] = this.occupation;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['QRcode'] = this.qRcode;
    data['member_id'] = this.memberId;
    data['isVerified'] = this.isVerified;
    data['profile_pic'] = this.profilePic;
    data['token_user'] = this.tokenUser;
    data['token_oneSignal'] = this.tokenOneSignal;
    data['token_firebase'] = this.tokenFirebase;
    data['device_type'] = this.deviceType;
    return data;
  }
}

class Address {
  String address;
  String province;
  String city;
  String district;
  String subdistrict;
  String postCode;
  String area;

  Address(
      {this.address,
      this.province,
      this.city,
      this.district,
      this.subdistrict,
      this.postCode,
      this.area});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    province = json['province'];
    city = json['city'];
    district = json['district'];
    subdistrict = json['subdistrict'];
    postCode = json['postCode'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['province'] = this.province;
    data['city'] = this.city;
    data['district'] = this.district;
    data['subdistrict'] = this.subdistrict;
    data['postCode'] = this.postCode;
    data['area'] = this.area;
    return data;
  }
}
