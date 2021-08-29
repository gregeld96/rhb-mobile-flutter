class ErrorResModel {
  int statusCode;
  String message;

  ErrorResModel({
    this.statusCode,
    this.message,
  });

  ErrorResModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status'];
    message = json['message'];
  }
}
