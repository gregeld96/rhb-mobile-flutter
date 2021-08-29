import 'package:flutter/material.dart';

class RehobotAddRemoveButton extends StatefulWidget {
  final Function() increaseFunction;
  final Function() decreaseFunction;
  final int value;
  final Color color;
  final Color iconColor;
  final Color activeColor;

  RehobotAddRemoveButton({
    @required this.color,
    @required this.increaseFunction,
    @required this.decreaseFunction,
    @required this.value,
    @required this.iconColor,
    @required this.activeColor,
    BuildContext context,
  });

  @override
  _RehobotAddRemoveButtonState createState() => _RehobotAddRemoveButtonState();
}

class _RehobotAddRemoveButtonState extends State<RehobotAddRemoveButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Ink(
          width: MediaQuery.of(context).size.width / 15,
          height: 30,
          decoration: ShapeDecoration(
            color: widget.color,
            shape: CircleBorder(),
          ),
          child: IconButton(
            onPressed: widget.decreaseFunction,
            icon: Icon(
              Icons.remove_sharp,
              color: widget.iconColor,
            ),
            iconSize: MediaQuery.of(context).size.width / 35,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Ink(
          width: 45,
          height: 30,
          decoration: ShapeDecoration(
            color: widget.value > 0 ? widget.activeColor : widget.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
          child: Center(
            child: Text(
              widget.value.toString(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Ink(
          width: MediaQuery.of(context).size.width / 15,
          height: 30,
          decoration: ShapeDecoration(
            color: widget.color,
            shape: CircleBorder(),
          ),
          child: IconButton(
            onPressed: widget.increaseFunction,
            icon: Icon(
              Icons.add_sharp,
              color: widget.iconColor,
            ),
            iconSize: MediaQuery.of(context).size.width / 35,
          ),
        ),
      ],
    );
  }
}
