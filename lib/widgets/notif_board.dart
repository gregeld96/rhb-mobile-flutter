import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class NotifBoard extends StatelessWidget {
  NotifBoard({@required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: RehobotThemes.indigoRehobot,
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      dashPattern: [6, 4],
      strokeWidth: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          child: Center(
            child: RehobotGeneralText(
              title: title,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
