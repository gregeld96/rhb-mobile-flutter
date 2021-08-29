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
    postCode = json['post_code'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['province'] = this.province;
    data['city'] = this.city;
    data['district'] = this.district;
    data['subdistrict'] = this.subdistrict;
    data['post_code'] = this.postCode;
    data['area'] = this.area;
    return data;
  }
}

class EmergencyResModel {
  Emergency data;
  String message;

  EmergencyResModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Emergency.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Emergency {
  String fullName;
  String gender;
  String relations;
  Address address;
  String phoneNumber;

  Emergency(
      {this.fullName,
      this.gender,
      this.relations,
      this.address,
      this.phoneNumber});

  Emergency.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    gender = json['gender'];
    relations = json['relationship'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    phoneNumber = json['phone_number'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['gender'] = this.gender;
    data['relationship'] = this.relations;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    } else {
      this.address = Address();
      data['address'] = this.address;
    }
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}
