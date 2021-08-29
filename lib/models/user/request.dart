class UserRequestResModel {
  List<UserRequest> data;
  String message;

  UserRequestResModel({this.data, this.message});

  UserRequestResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserRequest>[];
      json['data'].forEach((v) {
        data.add(new UserRequest.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class UserRequest {
  int id;
  String title;
  String date;
  String time;
  String role;
  String location;
  String banner;
  List<MusicMember> team;
  dynamic approval;

  UserRequest({
    this.id,
    this.title,
    this.date,
    this.time,
    this.role,
    this.location,
    this.banner,
    this.team,
    this.approval,
  });

  UserRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    time = json['time'];
    location = json['location'];
    role = json['role'];
    banner = json['banner'];
    if (json['team'] != null) {
      team = <MusicMember>[];
      json['team'].length > 0
          ? json['team'].forEach((v) {
              team.add(new MusicMember.fromJson(v));
            })
          : team = <MusicMember>[];
    }
    approval = json['approval'];
  }
}

class MusicMember {
  String userName;
  String roleName;

  MusicMember({this.roleName, this.userName});

  MusicMember.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    roleName = json['role_name'];
  }
}
