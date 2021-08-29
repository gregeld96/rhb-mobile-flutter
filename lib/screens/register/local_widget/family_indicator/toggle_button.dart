import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';

typedef OnToggle = void Function(int index);

class RehobotToggleButton extends StatefulWidget {
  RehobotToggleButton({
    @required this.value,
    @required this.onToggle,
    BuildContext context,
  });

  final int value;
  final OnToggle onToggle;

  @override
  _RehobotToggleButtonState createState() => _RehobotToggleButtonState();
}

class _RehobotToggleButtonState extends State<RehobotToggleButton> {
  List option = ['Yes', 'No'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        option.length,
        (index) {
          return widget.value == index
              ? Container(
                  child: RehobotButton().roundedButton(
                    title: option[index],
                    context: context,
                    height: 10,
                    widthDivider: 30,
                    radius: 5,
                    textColor: Colors.white,
                    buttonColor: RehobotThemes.activeRehobot,
                    onPressed: () {
                      widget.onToggle(index);
                    },
                  ),
                )
              : Container(
                  child: RehobotButton().roundedButton(
                    title: option[index],
                    context: context,
                    height: 10,
                    widthDivider: 30,
                    radius: 5,
                    textColor: RehobotThemes.indigoRehobot,
                    buttonColor: Colors.white,
                    onPressed: () {
                      widget.onToggle(index);
                    },
                  ),
                );
        },
      ),
    );
  }
}
