class VideoResModel {
  List<Video> data;
  String message;

  VideoResModel({this.data, this.message});

  VideoResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Video>[];
      json['data'].forEach((v) {
        data.add(new Video.fromJson(v));
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

class Video {
  int id;
  String videoFile;
  String section;

  Video({this.id, this.videoFile, this.section});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoFile = json['video_file'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video_file'] = this.videoFile;
    data['section'] = this.section;
    return data;
  }
}
