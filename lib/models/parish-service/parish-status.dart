class ParishStatusResModel {
  List<ParishStatus> data;
  String message;

  ParishStatusResModel({this.data, this.message});

  ParishStatusResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ParishStatus>[];
      json['data'].forEach((v) {
        data.add(new ParishStatus.fromJson(v));
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

class ParishStatus {
  String title;
  dynamic pic;
  dynamic status;
  String date;
  String time;

  ParishStatus({this.title, this.pic, this.status, this.date, this.time});

  ParishStatus.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    pic = json['pic'];
    status = json['status'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['pic'] = this.pic;
    data['status'] = this.status;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
