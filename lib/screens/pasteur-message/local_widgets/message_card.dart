import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class RehobotMessageCard extends StatefulWidget {
  RehobotMessageCard({
    @required this.title,
    @required this.publishedAt,
    @required this.summary,
    @required this.onTap,
  });

  final String title;
  final String publishedAt;
  final String summary;
  final Function() onTap;

  @override
  _RehobotMessageCardState createState() => _RehobotMessageCardState();
}

class _RehobotMessageCardState extends State<RehobotMessageCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              RehobotGeneralText(
                title: widget.publishedAt,
                alignment: Alignment.centerLeft,
                fontSize: 14,
                fontWeight: FontWeight.w300,
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
                height: 15,
              ),
              Text(
                widget.summary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
