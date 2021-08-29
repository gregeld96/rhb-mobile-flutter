class ScheduleResModel {
  List<Schedule> data;
  String message;

  ScheduleResModel({this.data, this.message});

  ScheduleResModel.fromJson(Map<String, dynamic> json) {
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
  int categoryId;
  String name;
  String date;
  String time;
  String youtubeLink;
  String banner;
  Pembicara pembicara;
  String location;
  bool status;

  Schedule({
    this.id,
    this.categoryId,
    this.name,
    this.date,
    this.time,
    this.youtubeLink,
    this.banner,
    this.pembicara,
    this.location,
    this.status,
  });

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    date = json['date'];
    time = json['time'];
    youtubeLink = json['youtube_link'];
    banner = json['banner'];
    pembicara = json['pembicara'] != null
        ? new Pembicara.fromJson(json['pembicara'])
        : null;
    location = json['location'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['date'] = this.date;
    data['time'] = this.time;
    data['youtube_link'] = this.youtubeLink;
    data['banner'] = this.banner;
    if (this.pembicara != null) {
      data['pembicara'] = this.pembicara.toJson();
    }
    data['location'] = this.location;
    data['status'] = this.status;
    return data;
  }
}

class Pembicara {
  String pasteur;
  String request;
  bool required;
  dynamic pasteurId;
  int commission;
  bool approved;

  Pembicara(
      {this.pasteur,
      this.request,
      this.required,
      this.pasteurId,
      this.commission});

  Pembicara.fromJson(Map<String, dynamic> json) {
    pasteur = json['pasteur'];
    request = json['request'];
    required = json['required'];
    pasteurId = json['pasteur_id'];
    commission = json['commission'];
    approved = json['approved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pasteur'] = this.pasteur;
    data['request'] = this.request;
    data['required'] = this.required;
    data['pasteur_id'] = this.pasteurId;
    data['commission'] = this.commission;
    data['approved'] = this.approved;
    return data;
  }
}
