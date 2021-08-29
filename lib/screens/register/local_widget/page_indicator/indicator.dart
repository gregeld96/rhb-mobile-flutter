import 'package:flutter/material.dart';

class PageIndicator extends StatefulWidget {
  PageIndicator({@required this.color, BuildContext context});

  final Color color;

  @override
  _PageIndicatorState createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 10,
        width: 20,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.indigo),
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
