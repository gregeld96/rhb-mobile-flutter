import 'package:flutter/material.dart';

class RehobotButtonSwitch extends StatefulWidget {
  final Function() onTaped;
  final Color colorActive;
  final Color colorInActive;
  final bool toggleValue;

  RehobotButtonSwitch({
    @required this.colorInActive,
    @required this.colorActive,
    @required this.toggleValue,
    @required this.onTaped,
    BuildContext context,
  });
  @override
  _RehobotButtonSwitchState createState() => _RehobotButtonSwitchState();
}

class _RehobotButtonSwitchState extends State<RehobotButtonSwitch> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      height: 30.0,
      width: 80.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: widget.toggleValue ? widget.colorActive : widget.colorInActive,
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            curve: Curves.easeIn,
            left: widget.toggleValue ? 50.0 : 0.0,
            right: widget.toggleValue ? 0.0 : 50.0,
            child: InkWell(
              onTap: widget.onTaped,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 350),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return RotationTransition(turns: animation, child: child);
                },
                child: Icon(
                  Icons.fiber_manual_record_sharp,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            duration: Duration(milliseconds: 350),
          )
        ],
      ),
    );
  }
}
