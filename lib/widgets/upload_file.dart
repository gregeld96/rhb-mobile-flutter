import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:rhb_mobile_flutter/widgets/loading_progress.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/view_image/view.dart';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:rhb_mobile_flutter/models/utils/picked-file.dart';

typedef FilePicked = void Function(PickFile data);

class RehobotFileUpload extends StatefulWidget {
  RehobotFileUpload({
    @required this.file,
    @required this.title,
    @required this.filePicked,
  });

  final PickFile file;
  final String title;
  final FilePicked filePicked;

  @override
  _RehobotFileUploadState createState() => _RehobotFileUploadState();
}

class _RehobotFileUploadState extends State<RehobotFileUpload> {
  final picker = ImagePicker();
  bool loading;
  double progressValue;
  ViewImageController controller = Get.put(ViewImageController());

  void removeFile() {
    widget.filePicked(null);
  }

  Future _getImageFromCamera() async {
    PickedFile pickedFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    setState(() {
      if (pickedFile != null) {
        PickFile _data =
            PickFile.from(PickFile(ext: 'jpg', path: pickedFile.path));
        loading = false;
        progressValue = 100;
        widget.filePicked(_data);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _getImageFromGallery() async {
    FilePickerResult pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg'],
    );

    setState(() {
      if (pickedFile != null) {
        PlatformFile file = pickedFile.files.first;

        PickFile _data =
            PickFile.from(PickFile(ext: file.extension, path: file.path));
        loading = false;
        progressValue = 100;
        widget.filePicked(_data);
      } else {
        print('No image selected.');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Upload Picture',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Divider(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _getImageFromCamera();
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Open Camera',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: RehobotThemes.indigoRehobot,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _getImageFromGallery();
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Open Gallery',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: RehobotThemes.indigoRehobot,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Close',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: RehobotThemes.indigoRehobot,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RehobotGeneralText(
          title: widget.title,
          alignment: Alignment.center,
          fontSize: 12,
          fontWeight: null,
        ),
        GestureDetector(
          onTap: () {
            _showPicker(context);
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              dashPattern: [6, 4],
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Container(
                  height: 150,
                  width: 220,
                  color: Colors.grey[350],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/Asset_15.svg',
                        width: 70,
                        height: 70,
                        alignment: Alignment.center,
                        color: RehobotThemes.indigoRehobot,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RehobotGeneralText(
                        title: 'Click here to upload picture',
                        alignment: Alignment.center,
                        fontSize: 10,
                        fontWeight: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        RehobotGeneralText(
          title: 'Max. Upload Size 3 MB',
          alignment: Alignment.center,
          fontSize: 10,
          fontWeight: null,
        ),
        RehobotGeneralText(
          title: 'File harus dalam bentuk JPG, atau PNG',
          alignment: Alignment.center,
          fontSize: 10,
          fontWeight: null,
        ),
        if (widget.file != null)
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      '${widget.file.path.split('/').last}',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.imagePage(widget.file.path, widget.file.ext);
                    },
                    child: Text(
                      'View Image',
                      style: TextStyle(
                        fontSize: 12,
                        color: RehobotThemes.indigoRehobot,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicatorApp(
                      loading: loading ?? false,
                      progressValue: progressValue ?? 100,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close_sharp,
                      size: 20,
                      color: RehobotThemes.indigoRehobot,
                    ),
                    onPressed: () {
                      removeFile();
                    },
                  ),
                ],
              )
            ],
          ),
      ],
    );
  }
}
