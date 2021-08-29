class HistoryResModel {
  List<History> data;
  int totalData;
  String message;

  HistoryResModel({this.data, this.totalData, this.message});

  HistoryResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <History>[];
      json['data'].forEach((v) {
        data.add(new History.fromJson(v));
      });
    }
    totalData = json['totalData'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['totalData'] = this.totalData;
    data['message'] = this.message;
    return data;
  }
}

class History {
  String title;
  String date;
  String time;
  String thumbnail;
  String role;

  History({this.title, this.date, this.time, this.thumbnail, this.role});

  History.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    time = json['time'];
    thumbnail = json['thumbnail'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['time'] = this.time;
    data['thumbnail'] = this.thumbnail;
    data['role'] = this.role;
    return data;
  }
}
