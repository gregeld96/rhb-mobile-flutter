import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/sizeconfig.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RehobotButton {
  roundedButton({
    @required String title,
    void Function() onPressed,
    @required BuildContext context,
    @required double height,
    @required double widthDivider,
    @required Color textColor,
    @required Color buttonColor,
    double radius = 30,
    double fontSize = 16,
    bool fontWeight = true,
    Color disabledColor = Colors.transparent,
  }) {
    SizeConfig().init(context);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) return disabledColor;
            return buttonColor; // Use the component's default.
          },
        ),
        elevation: MaterialStateProperty.all(3),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: buttonColor),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Container(
        height: SizeConfig.blockSizeHorizontal * height,
        width: SizeConfig.blockSizeHorizontal * widthDivider,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight ? FontWeight.bold : null,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  iconRoundButton({
    @required String title,
    @required String svgFile,
    @required Color svgColor,
    void Function() onPressed,
    @required BuildContext context,
    @required double height,
    @required double widthDivider,
    @required double iconHeight,
    @required double iconWidth,
    @required Color textColor,
    @required Color buttonColor,
    double radius = 30,
    double fontSize = 16,
    bool fontWeight = true,
    Color disabledColor = Colors.transparent,
  }) {
    SizeConfig().init(context);
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 0)),
        elevation: MaterialStateProperty.all(3),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) return disabledColor;
            return buttonColor; // Use the component's default.
          },
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: buttonColor),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Container(
        height: SizeConfig.blockSizeHorizontal * height,
        width: SizeConfig.blockSizeHorizontal * widthDivider,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgFile,
                width: iconWidth,
                height: iconHeight,
                alignment: Alignment.centerLeft,
                color: svgColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight ? FontWeight.bold : FontWeight.normal,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
