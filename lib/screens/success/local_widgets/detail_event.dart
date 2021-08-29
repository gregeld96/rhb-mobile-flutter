import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class DetailEventSuccess extends StatelessWidget {
  DetailEventSuccess({
    @required this.title,
    @required this.pic,
    @required this.date,
    @required this.time,
  });

  final String title;
  final String pic;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RehobotGeneralText(
          title: 'Detail Pendaftaran:',
          alignment: Alignment.centerLeft,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: RehobotGeneralText(
            title: title,
            alignment: Alignment.centerLeft,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        RehobotGeneralText(
          title: 'Pelaksana: $pic',
          alignment: Alignment.centerLeft,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        SizedBox(
          height: 15,
        ),
        RehobotGeneralText(
          title: '$date | $time',
          alignment: Alignment.centerLeft,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        RehobotGeneralText(
          title: 'di GSKI Rehobot',
          alignment: Alignment.centerLeft,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        SizedBox(
          height: 20,
        ),
        Divider(
          height: 1.5,
          thickness: 2,
          color: Colors.grey[400],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
