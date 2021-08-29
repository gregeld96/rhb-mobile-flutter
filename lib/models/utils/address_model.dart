class Address {
  String province;
  String city;
  String district;
  String subdistrict;
  String codePost;

  Address({
    this.province,
    this.city,
    this.district,
    this.subdistrict,
    this.codePost,
  });
}

class ProvinceResModel {
  int id;
  String provinsi;

  ProvinceResModel({this.id, this.provinsi});

  ProvinceResModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinsi = json['provinsi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provinsi'] = this.provinsi;
    return data;
  }
}

class CityResModel {
  int id;
  String kabupatenKota;

  CityResModel({this.id, this.kabupatenKota});

  CityResModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kabupatenKota = json['kabupaten_kota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kabupaten_kota'] = this.kabupatenKota;
    return data;
  }
}

class DistrictResModel {
  int id;
  String kecamatan;

  DistrictResModel({this.id, this.kecamatan});

  DistrictResModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kecamatan = json['kecamatan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kecamatan'] = this.kecamatan;
    return data;
  }
}

class Kelurahan {
  int id;
  String kelurahan;
  int kdPos;

  Kelurahan({this.id, this.kelurahan, this.kdPos});

  Kelurahan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kelurahan = json['kelurahan'];
    kdPos = json['kd_pos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kelurahan'] = this.kelurahan;
    data['kd_pos'] = this.kdPos;
    return data;
  }
}

class CodePost {
  String kdPost;

  CodePost({this.kdPost});

  CodePost.fromJson(Map<String, dynamic> json) {
    kdPost = json['kd_pos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kd_pos'] = this.kdPost;
    return data;
  }
}
