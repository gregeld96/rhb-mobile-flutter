import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';

class RehobotCheckBox extends StatefulWidget {
  RehobotCheckBox({
    @required this.description,
    @required this.value,
    @required this.onChanged,
    this.padding,
    BuildContext context,
  });

  final String description;
  final bool value;
  final Function(bool) onChanged;
  final double padding;

  @override
  _RehobotCheckBoxState createState() => _RehobotCheckBoxState();
}

class _RehobotCheckBoxState extends State<RehobotCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.padding != null ? widget.padding : 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            activeColor: RehobotThemes.activeRehobot,
            checkColor: Colors.white,
            value: widget.value,
            onChanged: widget.onChanged,
          ),
          Expanded(
            child: Text(
              widget.description,
            ),
          )
        ],
      ),
    );
  }
}
