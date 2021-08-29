class PickFile {
  String ext;
  String path;

  PickFile({this.ext, this.path});

  PickFile.from(PickFile json) {
    ext = json.ext;
    path = json.path;
  }
}
