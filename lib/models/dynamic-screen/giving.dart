class GivingResModel {
  Giving data;
  String message;

  GivingResModel({this.data, this.message});

  GivingResModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Giving.fromJson(json['data']) : null;
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

class Giving {
  int id;
  String bank;
  String holder;
  String noRek;
  String qr;

  Giving({this.id, this.bank, this.noRek, this.qr});

  Giving.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bank = json['bank'];
    holder = json['holder'];
    noRek = json['no_rek'];
    qr = json['qr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank'] = this.bank;
    data['holder'] = this.holder;
    data['no_rek'] = this.noRek;
    data['qr'] = this.qr;
    return data;
  }
}
