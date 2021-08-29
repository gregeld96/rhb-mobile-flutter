class SundaySchoolResModel {
  List<SundaySchool> data;
  String message;

  SundaySchoolResModel({this.data, this.message});

  SundaySchoolResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SundaySchool>[];
      json['data'].forEach((v) {
        data.add(new SundaySchool.fromJson(v));
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

class SundaySchool {
  int id;
  String quota;
  String title;
  String day;
  String time;
  int ageMin;
  int ageMax;
  String pic;
  List<String> activities;
  String banner;

  SundaySchool(
      {this.id,
      this.quota,
      this.title,
      this.day,
      this.time,
      this.ageMin,
      this.ageMax,
      this.pic,
      this.activities,
      this.banner});

  SundaySchool.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quota = json['quota'];
    title = json['title'];
    day = json['day'];
    time = json['time'];
    ageMin = json['age_min'];
    ageMax = json['age_max'];
    pic = json['pic'];
    activities = json['activities'].cast<String>();
    banner = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quota'] = this.quota;
    data['title'] = this.title;
    data['day'] = this.day;
    data['time'] = this.time;
    data['age_min'] = this.ageMin;
    data['age_max'] = this.ageMax;
    data['pic'] = this.pic;
    data['activities'] = this.activities;
    data['thumbnail'] = this.banner;
    return data;
  }
}
