import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/button_switch.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:rhb_mobile_flutter/screens/register/local_widget/family_indicator/add_remove.dart';

class RehobotFamilyIndicator extends StatefulWidget {
  final String iconPath;
  final String text;
  final String section;
  final dynamic value;
  final dynamic onTaped;
  final dynamic onAdd;
  final dynamic onRemove;

  RehobotFamilyIndicator({
    @required this.iconPath,
    @required this.text,
    @required this.section,
    this.value,
    this.onTaped,
    this.onAdd,
    this.onRemove,
    BuildContext context,
  });

  @override
  _RehobotFamilyIndicatorState createState() => _RehobotFamilyIndicatorState();
}

class _RehobotFamilyIndicatorState extends State<RehobotFamilyIndicator> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Card(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SvgPicture.asset(
                    widget.iconPath,
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    color: RehobotThemes.indigoRehobot,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RehobotGeneralText(
                    title: widget.text,
                    alignment: Alignment.center,
                    fontSize: 12,
                    fontWeight: null,
                  ),
                ],
              ),
            ),
          ),
          if (widget.section == 'partner')
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: RehobotButtonSwitch(
                colorActive: RehobotThemes.activeRehobot,
                colorInActive: RehobotThemes.inactiveRehobot,
                toggleValue: widget.value,
                onTaped: widget.onTaped,
              ),
            ),
          if (widget.section != 'partner')
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 2.5,
              ),
              child: RehobotAddRemoveButton(
                color: RehobotThemes.inactiveRehobot,
                increaseFunction: widget.onAdd,
                decreaseFunction: widget.onRemove,
                activeColor: RehobotThemes.activeRehobot,
                value: widget.value,
                iconColor: RehobotThemes.indigoRehobot,
              ),
            )
        ],
      ),
    );
  }
}
