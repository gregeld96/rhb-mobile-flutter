import 'package:flutter/material.dart';
import 'indicator.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';

class RehobotPageIndicator extends StatefulWidget {
  //Current Page
  final dynamic indexPage;

  //Maximal Page Length
  final dynamic maxPage;

  RehobotPageIndicator({
    @required this.indexPage,
    @required this.maxPage,
    BuildContext context,
  });

  @override
  _RehobotPageIndicatorState createState() => _RehobotPageIndicatorState();
}

class _RehobotPageIndicatorState extends State<RehobotPageIndicator> {
  @override
  Widget build(BuildContext context) {
    if (widget.indexPage == 0)
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i <= widget.maxPage; i++)
            PageIndicator(
              color: widget.indexPage == i
                  ? RehobotThemes.indigoRehobot
                  : RehobotThemes.pageRehobot,
            )
        ],
      );
    else if (widget.indexPage == widget.maxPage)
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i <= widget.maxPage; i++)
            PageIndicator(
              color: RehobotThemes.indigoRehobot,
            )
        ],
      );
    else
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i <= widget.maxPage; i++)
            PageIndicator(
              color: i == widget.maxPage
                  ? RehobotThemes.pageRehobot
                  : RehobotThemes.indigoRehobot,
            )
        ],
      );
  }
}
