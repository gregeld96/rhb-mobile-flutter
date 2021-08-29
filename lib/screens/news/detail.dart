import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailNewsScreen extends StatelessWidget {
  final String picture;
  final String description;
  final publicImage = RestApiController.publicImageAPI;
  final String url;

  DetailNewsScreen({
    this.picture,
    this.description,
    this.url,
  });

  Future<void> _launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().indigoAppBar(
        onpress: () {
          Get.back();
        },
        title: 'News',
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image(
                  image: NetworkImage(publicImage + '/news/$picture'),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              if (url != null && url != '')
                GestureDetector(
                  onTap: () {
                    _launchInWebViewWithJavaScript(url);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Tekan link disini',
                        style: TextStyle(
                          fontSize: 16,
                          color: RehobotThemes.indigoRehobot,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.input_outlined,
                        color: RehobotThemes.indigoRehobot,
                      )
                    ],
                  ),
                ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  text: description,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
