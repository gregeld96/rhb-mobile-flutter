class WorshipResModel {
  List<Section> data;
  String message;

  WorshipResModel({this.data, this.message});

  WorshipResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Section>[];
      json['data'].forEach((v) {
        data.add(new Section.fromJson(v));
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

class Section {
  int id;
  String title;
  List<Categories> categories;

  Section({this.id, this.title, this.categories});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int id;
  String title;
  String thumbnail;
  String description;

  Categories({this.id, this.title, this.thumbnail, this.description});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['description'] = this.description;
    return data;
  }
}
