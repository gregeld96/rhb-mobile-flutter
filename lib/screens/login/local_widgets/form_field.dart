import 'package:flutter/material.dart';

class RehobotTextFormField extends StatefulWidget {
  RehobotTextFormField(
      {@required this.labelText,
      @required this.validator,
      @required this.controller,
      this.onChanged,
      this.focusNode,
      @required this.suffixIcon,
      BuildContext context});

  final String labelText;
  final Function(String) validator;
  final bool suffixIcon;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;

  @override
  _RehobotTextFormFieldState createState() => _RehobotTextFormFieldState();
}

class _RehobotTextFormFieldState extends State<RehobotTextFormField> {
  bool _passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: TextFormField(
        onChanged: widget.onChanged,
        obscureText: widget.suffixIcon ? _passwordVisibility : false,
        textInputAction: TextInputAction.next,
        controller: widget.controller,
        validator: widget.validator,
        focusNode: widget.focusNode,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            labelText: widget.labelText,
            errorStyle: TextStyle(color: Colors.white),
            labelStyle: TextStyle(color: Colors.white),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
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
                      padding: const EdgeInsets.fromLTRB(30, 15, 0, 0),
                      child: Text(
                        _passwordVisibility ? 'Show' : 'Hide',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : null),
      ),
    );
  }
}
