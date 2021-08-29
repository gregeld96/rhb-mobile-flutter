import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:share/share.dart';

class DetailMessageScreen extends StatefulWidget {
  DetailMessageScreen({
    @required this.title,
    @required this.description,
    @required this.published,
    @required this.url,
  });

  final String title;
  final String description;
  final String published;
  final String url;

  @override
  _DetailMessageScreenState createState() => _DetailMessageScreenState();
}

class _DetailMessageScreenState extends State<DetailMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().generalAppBar(
        context: context,
        onpress: () {
          Navigator.pop(context);
        },
        title: "Kembali",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.published,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              RehobotGeneralText(
                title: widget.title,
                alignment: Alignment.centerLeft,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  text: widget.description,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: RehobotButton().roundedButton(
                  title: 'SHARE',
                  context: context,
                  height: 10,
                  widthDivider: 30,
                  textColor: RehobotThemes.indigoRehobot,
                  buttonColor: Colors.white,
                  onPressed: () {
                    final RenderBox box = context.findRenderObject();
                    Share.share(
                      widget.url,
                      subject: widget.title,
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
