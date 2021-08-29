import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';

class RehobotGeneralText extends StatelessWidget {
  RehobotGeneralText({
    @required this.title,
    @required this.alignment,
    @required this.fontSize,
    @required this.fontWeight,
    this.alignText,
    this.color,
    BuildContext context,
  });

  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Alignment alignment;
  final TextAlign alignText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Text(
        title,
        softWrap: true,
        textAlign: alignText,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? RehobotThemes.indigoRehobot,
        ),
      ),
    );
  }
}
