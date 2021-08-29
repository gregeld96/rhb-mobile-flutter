import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';

class RehobotTextField extends StatefulWidget {
  RehobotTextField({
    @required this.hintText,
    this.suffixIcon = false,
    @required this.validator,
    @required this.controller,
    @required this.onChanged,
    this.focusNode,
    this.textAlign,
    this.fontSize,
    this.maxLength,
    this.inputType,
    this.inputAction,
    this.capitalization,
    this.readOnly,
    BuildContext contex,
  });

  final String hintText;
  final bool suffixIcon;
  final Function(String) validator;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final TextAlign textAlign;
  final double fontSize;
  final int maxLength;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final TextCapitalization capitalization;
  final bool readOnly;

  @override
  _RehobotTextFieldState createState() => _RehobotTextFieldState();
}

class _RehobotTextFieldState extends State<RehobotTextField> {
  bool _passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: TextFormField(
        textCapitalization: widget.capitalization ?? TextCapitalization.none,
        readOnly: widget.readOnly ?? false,
        maxLength: widget.maxLength,
        validator: widget.validator,
        keyboardType: widget.inputType ?? TextInputType.text,
        onChanged: widget.onChanged,
        textAlign: widget.textAlign ?? TextAlign.start,
        textInputAction: widget.inputAction ?? TextInputAction.next,
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: widget.suffixIcon ? _passwordVisibility : false,
        style: TextStyle(
            color: RehobotThemes.indigoRehobot,
            fontSize: widget.fontSize ?? 16),
        decoration: InputDecoration(
            hintText: widget.hintText,
            counterText: '',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: widget.suffixIcon
                ? FlatButton(
                    onPressed: widget.suffixIcon
                        ? () {
                            setState(
                              () {
                                _passwordVisibility = !_passwordVisibility;
                              },
                            );
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        _passwordVisibility ? 'Show' : 'Hide',
                        style: TextStyle(
                          color: RehobotThemes.indigoRehobot,
                        ),
                      ),
                    ),
                  )
                : null),
      ),
    );
  }
}
