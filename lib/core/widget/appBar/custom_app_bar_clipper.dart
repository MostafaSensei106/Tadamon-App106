import 'package:flutter/material.dart';

class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);

    final firstCarve = Offset(0, size.height - 20);
    final secondCarve = Offset(30, size.height - 20);

    final secondFirstCarve = Offset(0, size.height - 20);
    final secondSecondCarve = Offset(size.width - 30, size.height - 20);

    final thirdFirstCarve = Offset(size.width, size.height - 20);
    final thirdSecondCarve = Offset(size.width, size.height);

    path.quadraticBezierTo(
        firstCarve.dx, firstCarve.dy, secondCarve.dx, secondCarve.dy);

    path.quadraticBezierTo(secondFirstCarve.dx, secondFirstCarve.dy,
        secondSecondCarve.dx, secondSecondCarve.dy);

    path.quadraticBezierTo(thirdFirstCarve.dx, thirdFirstCarve.dy,
        thirdSecondCarve.dx, thirdSecondCarve.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
