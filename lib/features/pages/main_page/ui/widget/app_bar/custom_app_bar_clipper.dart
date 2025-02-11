import 'package:flutter/material.dart';

class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  /// Generates a custom clip path that looks like a slightly curved
  /// trapezoid with a flat top and a rounded bottom. The top is flat
  /// because it is the top of the app bar, and the bottom is rounded
  /// because it is the bottom of the app bar and should be rounded for
  /// a more visually appealing design. The path is created by
  /// connecting a series of quadratic Bezier curves. The first curve
  /// goes from the top left to the bottom left, the second curve goes
  /// from the bottom left to the bottom right, and the third curve goes
  /// from the bottom right to the top right. The path is then closed
  /// with a line from the top right to the top left.
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
