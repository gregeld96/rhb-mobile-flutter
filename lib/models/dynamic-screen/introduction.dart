class IntroductionResModel {
  List<Intro> data;
  String message;

  IntroductionResModel({this.data, this.message});

  IntroductionResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Intro>[];
      json['data'].forEach((v) {
        data.add(new Intro.fromJson(v));
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

class Intro {
  int id;
  String title;
  String description;
  String image;
  int order;

  Intro({this.id, this.title, this.description, this.image, this.order});

  Intro.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['order'] = this.order;
    return data;
  }
}
