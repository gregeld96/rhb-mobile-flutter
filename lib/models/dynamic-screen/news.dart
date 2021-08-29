class NewsResModel {
  Detail data;
  String message;

  NewsResModel({this.data, this.message});

  NewsResModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Detail.fromJson(json['data']) : null;
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

class Detail {
  int count;
  List<News> news;

  Detail({this.count, this.news});

  Detail.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      news = <News>[];
      json['rows'].forEach((v) {
        news.add(new News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.news != null) {
      data['rows'] = this.news.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  int id;
  String picture;
  String description;
  String publishedAt;
  String url;

  News({
    this.id,
    this.picture,
    this.description,
    this.publishedAt,
    this.url,
  });

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    picture = json['picture'];
    description = json['description'];
    publishedAt = json['publishedAt'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['picture'] = this.picture;
    data['description'] = this.description;
    data['publishedAt'] = this.publishedAt;
    data['url'] = this.url;
    return data;
  }
}
