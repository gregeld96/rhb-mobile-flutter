class ParishResModel {
  List<Parish> data;
  String message;

  ParishResModel({this.data, this.message});

  ParishResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Parish>[];
      json['data'].forEach((v) {
        data.add(new Parish.fromJson(v));
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

class Parish {
  int id;
  String title;
  String pic;
  String quota;
  String date;
  String time;
  dynamic bpnDate;

  Parish(
      {this.id,
      this.title,
      this.pic,
      this.quota,
      this.date,
      this.time,
      this.bpnDate});

  Parish.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    pic = json['pic'];
    quota = json['quota'].toString();
    date = json['date'];
    time = json['time'];
    bpnDate = json['bpn_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['pic'] = this.pic;
    data['status'] = this.quota;
    data['date'] = this.date;
    data['time'] = this.time;
    data['bpn_date'] = this.bpnDate;
    return data;
  }
}
