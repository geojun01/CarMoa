import 'package:flutter/material.dart';

// 왼쪽 상단 모서리 대각선
class TriangleClipTopLeft extends CustomClipper<Path> {
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(10, 0);
    path.lineTo(0, 10);
    path.close();
    return path;
  }

  bool shouldReclip(TriangleClipTopLeft oldClipper) => false;
}

// 오른쪽 하단 모서리 대각선
class TriangleClipBottomRight extends CustomClipper<Path> {
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width - 10, size.height);
    path.lineTo(size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  bool shouldReclip(TriangleClipBottomRight oldClipper) => false;
}