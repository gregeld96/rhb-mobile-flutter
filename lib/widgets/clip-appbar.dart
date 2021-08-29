import 'package:flutter/material.dart';

class CustomAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 15, size.height - 20, size.width - 80, size.height - 12);
    path.quadraticBezierTo(
        size.width, size.height - 8, size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldclipper) {
    return false;
  }
}
