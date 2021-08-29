import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class RehobotHistoryCard extends StatelessWidget {
  final String icon;
  final String title;
  final String date;
  final String time;
  final String role;
  final MainAxisAlignment mainAxisAlignment;

  RehobotHistoryCard({
    this.title,
    this.date,
    this.icon,
    this.time,
    this.role,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Card(
              shape: CircleBorder(),
              elevation: 3,
              child: Container(
                width: 50,
                height: 50,
                decoration: new BoxDecoration(
                  color: icon == '' ? RehobotThemes.indigoRehobot : null,
                  shape: BoxShape.circle,
                  image: icon != ''
                      ? new DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(icon),
                        )
                      : null,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RehobotGeneralText(
                      title: title,
                      alignment: Alignment.centerLeft,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    Text(
                      '$date | $time',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            RehobotGeneralText(
              title: role,
              alignment: Alignment.centerLeft,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            )
          ],
        ),
      ),
      Divider(
        height: 5,
        thickness: 1,
      )
    ]);
  }
}
