import 'package:flutter/cupertino.dart';

class ClipperCircle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 50);
    var d1 = Offset(size.width / 2, size.height);
    var d2 = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(d1.dx, d1.dy, d2.dx, d2.dy);
    path.lineTo(size.width, size.height - 50);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
