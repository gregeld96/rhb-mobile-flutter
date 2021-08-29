class HomeResModel {
  List<Schedule> data;
  String message;

  HomeResModel({this.data, this.message});

  HomeResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Schedule>[];
      json['data'].forEach((v) {
        data.add(new Schedule.fromJson(v));
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

class Schedule {
  int id;
  String area;
  String day;
  String time;
  String section;

  Schedule({this.id, this.area, this.day, this.time, this.section});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'];
    day = json['day'];
    time = json['time'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['area'] = this.area;
    data['day'] = this.day;
    data['time'] = this.time;
    data['section'] = this.section;
    return data;
  }
}
