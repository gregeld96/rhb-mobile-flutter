class ChatResModel {
  List<Chat> data;
  String message;

  ChatResModel({this.data, this.message});

  ChatResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Chat>[];
      json['data'].forEach((v) {
        data.add(new Chat.fromJson(v));
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

class Chat {
  int userId;
  dynamic seenAt;
  int sentAt;
  String message;

  Chat({
    this.userId,
    this.seenAt,
    this.sentAt,
    this.message,
  });

  Chat.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    seenAt = json['seenAt'] != '' ? json['seenAt'] : '';
    sentAt = json['sentAt'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['seenAt'] = this.seenAt;
    data['sentAt'] = this.sentAt;
    data['message'] = this.message;
    return data;
  }
}
