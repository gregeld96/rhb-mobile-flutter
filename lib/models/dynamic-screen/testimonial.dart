class TestimonyResModel {
  List<Testimony> data;
  String message;

  TestimonyResModel({this.data, this.message});

  TestimonyResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Testimony>[];
      json['data'].forEach((v) {
        data.add(new Testimony.fromJson(v));
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

class Testimony {
  int id;
  String name;
  String testimony;
  String photo;
  String section;

  Testimony({this.id, this.name, this.testimony, this.photo, this.section});

  Testimony.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    testimony = json['testimony'];
    photo = json['photo'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['testimony'] = this.testimony;
    data['photo'] = this.photo;
    data['section'] = this.section;
    return data;
  }
}
