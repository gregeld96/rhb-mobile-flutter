import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class HelpScreen extends StatelessWidget {
  final String title;
  final String description;

  HelpScreen({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().indigoAppBar(
        onpress: () {
          Get.back();
        },
        title: 'Help',
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RehobotGeneralText(
              title: title,
              alignment: Alignment.center,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: RehobotGeneralText(
                title: description,
                alignment: Alignment.center,
                alignText: TextAlign.justify,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
