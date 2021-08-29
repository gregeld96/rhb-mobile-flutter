class PasteurMessageResModel {
  String message;
  List<PasteurMessage> data;
  int total;

  PasteurMessageResModel({this.message, this.data});

  PasteurMessageResModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['total'] != null) {
      total = json['total'];
    }
    if (json['data'] != null) {
      data = <PasteurMessage>[];
      json['data'].forEach((v) {
        data.add(new PasteurMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PasteurMessage {
  int id;
  String title;
  String summary;
  String description;
  String publishedAt;

  PasteurMessage(
      {this.id, this.title, this.summary, this.description, this.publishedAt});

  PasteurMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    summary = json['summary'];
    description = json['description'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['description'] = this.description;
    data['publishedAt'] = this.publishedAt;
    return data;
  }
}
