import 'package:flutter/material.dart';

class BarShape extends CustomClipper<Path>{
  BarShape(this.shadow);
  bool shadow;

  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    if (!shadow) {
      path.lineTo(0, height - 50);
      path.quadraticBezierTo(width/2, height, width, height - 50);
      path.lineTo(width, 0);
    } else {
      path.lineTo(0, height - 38);
      path.quadraticBezierTo(width/2, height - 11, width, height - 38);
      path.lineTo(width, 0);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}