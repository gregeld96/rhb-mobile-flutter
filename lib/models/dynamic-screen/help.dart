class HelpResModel {
  Help help;
  String message;

  HelpResModel({this.help, this.message});

  HelpResModel.fromJson(Map<String, dynamic> json) {
    help = json['data'] != null ? new Help.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.help != null) {
      data['data'] = this.help.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Help {
  int id;
  String title;
  String description;

  Help({this.id, this.title, this.description});

  Help.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
