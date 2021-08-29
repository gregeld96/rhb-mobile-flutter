import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class SuccessScreen extends StatefulWidget {
  SuccessScreen({
    @required this.imageName,
    @required this.onPress,
    @required this.description,
    @required this.buttonTitle,
    this.titleSize,
    this.imageScale,
    this.imagePadding,
    this.title,
  });

  final String imageName;
  final String buttonTitle;
  final Function() onPress;
  final String description;
  final String title;
  final double imageScale;
  final double titleSize;
  final double imagePadding;

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Container(
                padding: EdgeInsets.all(
                  widget.imagePadding ?? MediaQuery.of(context).size.width / 8,
                ),
                child: Image.asset(
                  'assets/images/${widget.imageName}',
                  scale: 0.5,
                  fit: BoxFit.fitWidth,
                ),
              ),
              if (widget.title != null)
                Container(
                  child: Column(
                    children: [
                      RehobotGeneralText(
                        title: widget.title,
                        alignment: Alignment.center,
                        fontSize: widget.titleSize ?? 24,
                        fontWeight: FontWeight.normal,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: RehobotGeneralText(
                  title: widget.description,
                  alignment: Alignment.center,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  alignText: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              RehobotButton().roundedButton(
                title: widget.buttonTitle,
                context: context,
                height: 10,
                widthDivider: 20,
                textColor: Colors.white,
                buttonColor: RehobotThemes.activeRehobot,
                onPressed: widget.onPress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
