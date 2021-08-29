class UserRolesResModel {
  int data;
  String message;

  UserRolesResModel({this.data, this.message});

  UserRolesResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = json['data'];
    }
    message = json['message'];
  }
}
