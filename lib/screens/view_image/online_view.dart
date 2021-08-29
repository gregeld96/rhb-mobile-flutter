import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';

class OnlineViewScreen extends StatelessWidget {
  OnlineViewScreen({
    this.document,
  });

  final String document;
  final String url = RestApiController.privateImageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().generalAppBar(
        onpress: () {
          Navigator.of(context).pop();
        },
        title: 'Kembali',
        context: context,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Image(
              image: NetworkImage(url + document),
            ),
          )
        ],
      ),
    );
  }
}
