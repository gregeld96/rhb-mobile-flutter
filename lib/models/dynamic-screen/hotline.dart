class HotlineResModel {
  Hotline data;
  String message;

  HotlineResModel({this.data, this.message});

  HotlineResModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Hotline.fromJson(json['data']) : null;
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

class Hotline {
  int id;
  dynamic address;
  dynamic city;
  dynamic codePost;
  String hotline;
  String section;

  Hotline(
      {this.id,
      this.address,
      this.city,
      this.codePost,
      this.hotline,
      this.section});

  Hotline.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    city = json['city'];
    codePost = json['code_post'];
    hotline = json['hotline'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['city'] = this.city;
    data['code_post'] = this.codePost;
    data['hotline'] = this.hotline;
    data['section'] = this.section;
    return data;
  }
}
