import 'package:flutter/material.dart';

class LinearProgressIndicatorApp extends StatefulWidget {
  LinearProgressIndicatorApp({
    @required this.loading,
    @required this.progressValue,
    BuildContext context,
  });

  final bool loading;
  final double progressValue;

  @override
  State<StatefulWidget> createState() {
    return LinearProgressIndicatorAppState();
  }
}

class LinearProgressIndicatorAppState
    extends State<LinearProgressIndicatorApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: widget.loading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearProgressIndicator(
                    backgroundColor: Colors.cyanAccent,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    value: 100,
                  ),
                  Text('${(widget.progressValue * 100).round()}%'),
                ],
              )
            : LinearProgressIndicator(
                backgroundColor: Colors.cyanAccent,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                value: 0,
              ),
      ),
    );
  }
}
