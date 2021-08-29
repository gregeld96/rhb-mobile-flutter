class ContactComissionResModel {
  List<ContactCommission> data;
  String message;

  ContactComissionResModel({this.data, this.message});

  ContactComissionResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ContactCommission>[];
      json['data'].forEach((v) {
        data.add(new ContactCommission.fromJson(v));
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

class ContactCommission {
  int id;
  String title;
  String description;
  String logo;
  String leaderName;
  String leaderPhone;
  String leaderPic;

  ContactCommission(
      {this.id,
      this.title,
      this.description,
      this.logo,
      this.leaderName,
      this.leaderPhone,
      this.leaderPic});

  ContactCommission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    logo = json['logo'];
    leaderName = json['leader_name'];
    leaderPhone = json['leader_phone'];
    leaderPic = json['leader_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['logo'] = this.logo;
    data['leader_name'] = this.leaderName;
    data['leader_phone'] = this.leaderPhone;
    data['leader_pic'] = this.leaderPic;
    return data;
  }
}
