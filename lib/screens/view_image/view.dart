import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/view_image/view.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'dart:io';

class ViewImageScreen extends StatefulWidget {
  ViewImageScreen({
    @required this.file,
    @required this.ext,
    BuildContext context,
  });

  final String file;
  final String ext;

  @override
  _ViewImageScreenState createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  ViewImageController controller = Get.put(ViewImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().generalAppBar(
          context: context,
          title: 'Kembali',
          onpress: () {
            controller.back();
          }),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Center(
              child: Image.file(
                File(widget.file),
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
